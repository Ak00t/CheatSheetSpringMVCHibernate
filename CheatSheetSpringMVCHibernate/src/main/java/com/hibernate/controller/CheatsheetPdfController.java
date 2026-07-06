package com.hibernate.controller;

import java.awt.Color;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hibernate.entity.CheatsheetEntity;
import com.hibernate.entity.CheatsheetNoteEntity;
import com.hibernate.entity.CheatsheetRowCellEntity;
import com.hibernate.entity.CheatsheetRowEntity;
import com.hibernate.entity.CheatsheetSectionEntity;
import com.hibernate.service.CheatsheetService;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/cheatsheet")
public class CheatsheetPdfController {

    private final CheatsheetService cheatsheetService;

    @GetMapping("/pdf/{id}")
    public void downloadPdf(@PathVariable Long id,
                            HttpServletResponse response) {

        try {
            CheatsheetEntity cheatsheet = cheatsheetService.findDetailsById(id);

            if (cheatsheet == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            response.setContentType("application/pdf");
            response.setHeader(
                    "Content-Disposition",
                    "attachment; filename=Cheatsheet_" + id + ".pdf"
            );

            Document document = new Document(PageSize.A4.rotate(), 45, 45, 35, 35);
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Color themeColor = parseColor(cheatsheet.getThemeColor(), new Color(78, 205, 239));
            Color darkText = new Color(31, 41, 55);
            Color grayText = new Color(75, 85, 99);
            Color lightBg = new Color(249, 250, 251);
            Color borderColor = new Color(229, 231, 235);
            Color noteBg = new Color(255, 248, 220);
            Color noteBorder = new Color(245, 158, 11);

            Font titleFont = new Font(Font.HELVETICA, 24, Font.BOLD, darkText);
            Font authorFont = new Font(Font.HELVETICA, 24, Font.BOLD, themeColor);
            Font descFont = new Font(Font.HELVETICA, 11, Font.NORMAL, grayText);
            Font sectionFont = new Font(Font.HELVETICA, 13, Font.BOLD, darkText);
            Font rowFont = new Font(Font.HELVETICA, 9, Font.BOLD, new Color(17, 24, 39));
            Font cellFont = new Font(Font.HELVETICA, 9, Font.NORMAL, grayText);
            Font noteTitleFont = new Font(Font.HELVETICA, 10, Font.BOLD, new Color(120, 80, 0));
            Font noteTextFont = new Font(Font.HELVETICA, 9, Font.NORMAL, darkText);

            String author = cheatsheet.getUser() != null
                    ? cheatsheet.getUser().getName()
                    : "-";

            Paragraph title = new Paragraph();
            title.add(new Phrase(cheatsheet.getTitle() + " ", titleFont));
            title.add(new Phrase("by " + author, authorFont));
            title.setSpacingAfter(10);
            document.add(title);

            if (cheatsheet.getDescription() != null) {
                Paragraph desc = new Paragraph(cheatsheet.getDescription(), descFont);
                desc.setSpacingAfter(20);
                document.add(desc);
            }

            List<CheatsheetSectionEntity> sections = new ArrayList<>();
            if (cheatsheet.getSections() != null) {
                sections.addAll(cheatsheet.getSections());
            }

            PdfPTable mainGrid = new PdfPTable(2);
            mainGrid.setWidthPercentage(100);
            mainGrid.setWidths(new float[]{1f, 1f});
            mainGrid.setSpacingBefore(5);

            for (CheatsheetSectionEntity section : sections) {
                PdfPCell cardCell = createSectionCard(
                        section,
                        themeColor,
                        lightBg,
                        borderColor,
                        noteBg,
                        noteBorder,
                        sectionFont,
                        rowFont,
                        cellFont,
                        noteTitleFont,
                        noteTextFont
                );

                mainGrid.addCell(cardCell);
            }

            if (sections.size() % 2 != 0) {
                PdfPCell empty = new PdfPCell(new Phrase(""));
                empty.setBorder(Rectangle.NO_BORDER);
                mainGrid.addCell(empty);
            }

            document.add(mainGrid);

            Paragraph footer = new Paragraph(
                    "Generated by CheatSheet Hub",
                    new Font(Font.HELVETICA, 8, Font.NORMAL, new Color(107, 114, 128))
            );
            footer.setAlignment(Element.ALIGN_CENTER);
            footer.setSpacingBefore(15);
            document.add(footer);

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("PDF export failed : " + e.getMessage());
        }
    }

    private PdfPCell createSectionCard(
            CheatsheetSectionEntity section,
            Color themeColor,
            Color lightBg,
            Color borderColor,
            Color noteBg,
            Color noteBorder,
            Font sectionFont,
            Font rowFont,
            Font cellFont,
            Font noteTitleFont,
            Font noteTextFont) {

        PdfPCell outerCell = new PdfPCell();
        outerCell.setPadding(8);
        outerCell.setBorder(Rectangle.NO_BORDER);

        PdfPTable card = new PdfPTable(1);
        card.setWidthPercentage(100);

        PdfPCell topLine = new PdfPCell(new Phrase(""));
        topLine.setFixedHeight(4);
        topLine.setBackgroundColor(themeColor);
        topLine.setBorder(Rectangle.NO_BORDER);
        card.addCell(topLine);

        PdfPCell titleCell = new PdfPCell(
                new Phrase(section.getTitle() == null ? "" : section.getTitle(), sectionFont)
        );
        titleCell.setPadding(12);
        titleCell.setBorderColor(borderColor);
        titleCell.setBorderWidth(0.7f);
        titleCell.setBackgroundColor(Color.WHITE);
        card.addCell(titleCell);

        PdfPCell bodyCell = new PdfPCell();
        bodyCell.setPadding(12);
        bodyCell.setBorderColor(borderColor);
        bodyCell.setBorderWidth(0.7f);
        bodyCell.setBackgroundColor(Color.WHITE);

        if (section.getRows() != null) {
            PdfPTable rowsTable = new PdfPTable(3);
            rowsTable.setWidthPercentage(100);
            rowsTable.setWidths(new float[]{30f, 28f, 42f});
            rowsTable.setSpacingAfter(10);

            for (CheatsheetRowEntity row : section.getRows()) {
                if (row.getCells() == null || row.getCells().isEmpty()) {
                    continue;
                }

                for (CheatsheetRowCellEntity cell : row.getCells()) {
                    rowsTable.addCell(noBorderCell(row.getRowTitle(), rowFont, lightBg, Element.ALIGN_LEFT));
                    rowsTable.addCell(noBorderCell(cell.getCellKey(), cellFont, lightBg, Element.ALIGN_CENTER));
                    rowsTable.addCell(noBorderCell(cell.getCellValue(), cellFont, lightBg, Element.ALIGN_RIGHT));
                }
            }

            bodyCell.addElement(rowsTable);
        }

        if (section.getNotes() != null) {
            for (CheatsheetNoteEntity note : section.getNotes()) {
                PdfPTable noteBox = new PdfPTable(1);
                noteBox.setWidthPercentage(100);
                noteBox.setSpacingBefore(10);

                PdfPCell noteCell = new PdfPCell();
                noteCell.setPadding(10);
                noteCell.setBackgroundColor(noteBg);
                noteCell.setBorderColor(noteBorder);
                noteCell.setBorderWidthLeft(3f);
                noteCell.setBorderWidthTop(0f);
                noteCell.setBorderWidthRight(0f);
                noteCell.setBorderWidthBottom(0f);

                Paragraph noteTitle = new Paragraph(
                        "💡 " + (note.getNoteTitle() == null ? "Note" : note.getNoteTitle()),
                        noteTitleFont
                );
                noteTitle.setSpacingAfter(5);
                noteCell.addElement(noteTitle);

                if (note.getNoteContent() != null) {
                    noteCell.addElement(new Paragraph(note.getNoteContent(), noteTextFont));
                }

                noteBox.addCell(noteCell);
                bodyCell.addElement(noteBox);
            }
        }

        card.addCell(bodyCell);
        outerCell.addElement(card);

        return outerCell;
    }

    private PdfPCell noBorderCell(String text,
                                  Font font,
                                  Color bg,
                                  int align) {
        PdfPCell cell = new PdfPCell(new Phrase(text == null ? "" : text, font));
        cell.setPadding(8);
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setBackgroundColor(bg);
        cell.setHorizontalAlignment(align);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        return cell;
    }

    private Color parseColor(String hex, Color defaultColor) {
        try {
            if (hex == null || hex.trim().isEmpty()) {
                return defaultColor;
            }
            return Color.decode(hex.trim());
        } catch (Exception e) {
            return defaultColor;
        }
    }
}