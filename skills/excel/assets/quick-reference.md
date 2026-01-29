# Quick Reference

Fast lookup for common Excel operations.

## Most Common Operations

### Create a New File
```
excel_create_workbook(filepath="/path/to/file.xlsx")
```

### Read Data
```
excel_read_data_from_excel(
  filepath="/path/to/file.xlsx",
  sheet_name="SheetName",
  start_cell="A1",
  end_cell="D100"
)
```

### Write Data
```
excel_write_data_to_excel(
  filepath="/path/to/file.xlsx",
  sheet_name="SheetName",
  data=[["Header1", "Header2"], ["Value1", "Value2"]],
  start_cell="A1"
)
```

### Add Formula
```
excel_apply_formula(
  filepath="/path/to/file.xlsx",
  sheet_name="SheetName",
  cell="E2",
  formula="=SUM(B2:D2)"
)
```

### Format Cells
```
excel_format_range(
  filepath="/path/to/file.xlsx",
  sheet_name="SheetName",
  start_cell="A1",
  end_cell="D1",
  bold=true,
  bg_color="#0066CC",
  font_color="#FFFFFF"
)
```

### Create Chart
```
excel_create_chart(
  filepath="/path/to/file.xlsx",
  sheet_name="SheetName",
  data_range="A1:B10",
  chart_type="bar",
  target_cell="D1"
)
```

### Create Pivot Table
```
excel_create_pivot_table(
  filepath="/path/to/file.xlsx",
  sheet_name="SourceSheet",
  data_range="A1:D100",
  rows=["Category"],
  values=["Amount"],
  agg_func="sum"
)
```

---

## Number Formats Cheat Sheet

| Format | Code | Example |
|--------|------|---------|
| Currency | `$#,##0.00` | $1,234.56 |
| Percentage | `0.00%` | 45.67% |
| Thousands | `#,##0` | 1,234,567 |
| 2 Decimals | `0.00` | 1234.56 |
| Date | `MM/DD/YYYY` | 01/28/2025 |
| Time | `HH:MM:SS` | 14:30:45 |
| Scientific | `0.00E+00` | 1.23E+03 |

---

## Common Formulas

| Purpose | Formula |
|---------|---------|
| Sum range | `=SUM(B2:B10)` |
| Average | `=AVERAGE(B2:B10)` |
| Count | `=COUNT(B2:B10)` |
| If/Then | `=IF(B2>100, "High", "Low")` |
| Lookup | `=VLOOKUP(A2, Table, 2)` |
| Concatenate | `=CONCATENATE(A2, B2)` |
| Uppercase | `=UPPER(A2)` |
| Text length | `=LEN(A2)` |

---

## Color Reference

### Basic Colors (Hex)
- White: `#FFFFFF`
- Black: `#000000`
- Red: `#FF0000`
- Green: `#00FF00`
- Blue: `#0000FF`
- Yellow: `#FFFF00`

### Professional Colors
- Dark Blue: `#0066CC`
- Light Gray: `#CCCCCC`
- Medium Gray: `#999999`
- Light Green: `#00CC99`
- Orange: `#FF9900`

---

## Workflow Checklist

**Data Import**:
- [ ] Create workbook
- [ ] Create "Raw" sheet
- [ ] Write raw data
- [ ] Preview data quality
- [ ] Create "Clean" sheet
- [ ] Add transformation formulas
- [ ] Copy formulas down
- [ ] Review cleaned data

**Report Creation**:
- [ ] Create workbook
- [ ] Add title (merged cells)
- [ ] Add headers (formatted)
- [ ] Write data
- [ ] Add summary formulas
- [ ] Create chart
- [ ] Format for printing
- [ ] Save

**Data Analysis**:
- [ ] Read source data
- [ ] Create analysis sheet
- [ ] Add formulas
- [ ] Create pivot table
- [ ] Create visualizations
- [ ] Add insights/notes
- [ ] Format professionally

---

**Quick Reference Version**: 1.0
**Last Updated**: 2025-01-28
