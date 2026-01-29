# Cell Operations Guide

Comprehensive guide to formatting, formulas, and cell-level operations.

## Cell Formatting Fundamentals

### Understanding Format Parameters

When formatting cells, you can control:

| Parameter | Type | Examples | Default |
|-----------|------|----------|---------|
| `bold` | boolean | true, false | false |
| `italic` | boolean | true, false | false |
| `underline` | boolean | true, false | false |
| `font_size` | integer | 10, 12, 14, 16 | 11 |
| `font_color` | string | "#FF0000", "red", "#FFFFFF" | black |
| `bg_color` | string | "#CCCCCC", "yellow", "#0066CC" | none |
| `alignment` | string | "left", "center", "right" | left |
| `wrap_text` | boolean | true, false | false |
| `number_format` | string | "$#,##0.00", "0.00%", "MM/DD/YYYY" | default |
| `border_style` | string | "thin", "medium", "thick", "dashed" | none |
| `border_color` | string | "#000000", "black" | black |

### Basic Formatting

**Bold headers**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  bold=true
)
```

**Colored backgrounds**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  bg_color="#0066CC",
  font_color="#FFFFFF"
)
```

**Large font**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="A1",
  font_size=18,
  bold=true
)
```

**Multiple formats combined**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  bold=true,
  italic=true,
  font_size=12,
  bg_color="#CCCCCC",
  alignment="center",
  wrap_text=true
)
```

### Colors

**Named colors**:
- Common: "red", "blue", "green", "yellow", "orange", "purple", "pink", "gray", "black", "white"
- Can use names for basic colors

**Hex colors**:
- Format: "#RRGGBB" where RR, GG, BB are hexadecimal
- Examples:
  - White: "#FFFFFF"
  - Black: "#000000"
  - Red: "#FF0000"
  - Blue: "#0000FF"
  - Green: "#00FF00"
  - Gray: "#808080"
  - Light gray: "#CCCCCC"
  - Dark blue: "#003366"

### Text Alignment

**Horizontal alignment**:
```
# Center alignment (good for headers)
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  alignment="center"
)

# Right alignment (good for numbers)
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="B2",
  end_cell="D100",
  alignment="right"
)

# Left alignment (default for text)
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A2",
  end_cell="A100",
  alignment="left"
)
```

**Vertical alignment** (through alignment parameter):
```
# Top, center, bottom
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D10",
  alignment="center",  # Also can include vertical
  wrap_text=true
)
```

### Borders

**Add borders**:
```
# Thin borders
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D10",
  border_style="thin",
  border_color="#000000"
)

# Medium borders
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  border_style="medium",
  border_color="#0066CC"
)

# Thick borders
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  border_style="thick",
  border_color="#000000"
)

# Dashed borders
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D10",
  border_style="dashed",
  border_color="#999999"
)
```

---

## Number Formatting

Number formats control how numbers are displayed (not the value itself).

### Common Number Formats

**Currency (US dollars)**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Financial",
  start_cell="B2",
  end_cell="B1000",
  number_format="$#,##0.00"
)
```
Display: $1,234.56

**Percentage**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="C2",
  end_cell="C1000",
  number_format="0.00%"
)
```
Display: 45.67%

**Thousands separator**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  number_format="#,##0"
)
```
Display: 1,234,567

**Two decimal places**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  number_format="0.00"
)
```
Display: 1234.56

**No decimal places**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  number_format="0"
)
```
Display: 1235 (rounded)

**Leading zeros**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  number_format="00000"
)
```
Display: 00123

**Negative in parentheses**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Financial",
  start_cell="B2",
  end_cell="B1000",
  number_format="$#,##0.00_);($#,##0.00)"
)
```
Display: $1,234.56 or ($1,234.56) for negative

---

## Date and Time Formatting

**Short date (MM/DD/YYYY)**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  number_format="MM/DD/YYYY"
)
```
Display: 01/28/2025

**Long date (Month Day, Year)**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  number_format="MMMM DD, YYYY"
)
```
Display: January 28, 2025

**Time (HH:MM:SS)**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  number_format="HH:MM:SS"
)
```
Display: 14:30:45

**Date and time**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A2",
  end_cell="A1000",
  number_format="MM/DD/YYYY HH:MM"
)
```
Display: 01/28/2025 14:30

---

## Merging and Unmerging Cells

### Merging Cells

Merge cells for titles and headers:

```
# Merge for title
excel_merge_cells(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1"
)

# Write title in merged cell
excel_write_data_to_excel(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  data=[["Quarterly Sales Report"]],
  start_cell="A1"
)

# Format merged cell
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  bold=true,
  font_size=16,
  alignment="center",
  bg_color="#0066CC",
  font_color="#FFFFFF"
)
```

### Unmerging Cells

Remove merge formatting:

```
excel_unmerge_cells(
  filepath="/data.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1"
)
```

### Checking for Merged Cells

Find all merged cells in a sheet:

```
merged_cells = excel_get_merged_cells(
  filepath="/data.xlsx",
  sheet_name="Sheet1"
)

# Returns array like: ["A1:D1", "A10:B15", ...]
```

**Caution**: Operations on merged cells may behave unexpectedly. Always unmerge before significant operations.

---

## Formula Operations

### Applying Formulas

Basic formula:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=B2*C2"
)
```

Formula must start with `=` character.

### Validating Formulas

Always validate formula syntax before applying to many cells:

```
# Check syntax
excel_validate_formula_syntax(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=SUM(B2:D2)"
)

# If valid, then apply
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=SUM(B2:D2)"
)
```

### Common Formula Functions

**Math**:
- `=SUM(B2:D2)` - Sum a range
- `=AVERAGE(B2:D2)` - Average of range
- `=PRODUCT(B2:D2)` - Multiply values
- `=SQRT(A1)` - Square root
- `=ROUND(A1, 2)` - Round to 2 decimals
- `=ABS(A1)` - Absolute value

**Logic**:
- `=IF(A1>100, "High", "Low")` - Conditional
- `=AND(A1>0, B1<100)` - All conditions true
- `=OR(A1>100, B1<10)` - Any condition true
- `=NOT(A1>100)` - Negate condition

**Text**:
- `=UPPER(A1)` - Uppercase
- `=LOWER(A1)` - Lowercase
- `=CONCATENATE(A1, B1)` - Join text
- `=LEN(A1)` - Text length
- `=TRIM(A1)` - Remove spaces
- `=LEFT(A1, 3)` - First 3 characters
- `=RIGHT(A1, 3)` - Last 3 characters
- `=FIND("text", A1)` - Find position
- `=SUBSTITUTE(A1, "old", "new")` - Replace text

**Lookup**:
- `=VLOOKUP(A1, Table, 2)` - Vertical lookup
- `=HLOOKUP(A1, Table, 2)` - Horizontal lookup
- `=INDEX(Range, 2, 3)` - Get value by position
- `=MATCH(A1, Range)` - Find position

**Date**:
- `=TODAY()` - Current date
- `=MONTH(A1)` - Extract month
- `=YEAR(A1)` - Extract year
- `=DAY(A1)` - Extract day
- `=DATEDIF(A1, B1, "D")` - Days between dates

**Count**:
- `=COUNT(A2:A100)` - Count numeric cells
- `=COUNTA(A2:A100)` - Count non-empty cells
- `=COUNTIF(A2:A100, ">100")` - Count matching criteria
- `=COUNTIFS(A2:A100, ">100", B2:B100, "Yes")` - Multiple criteria

### Cross-Sheet Formulas

Reference cells from other sheets:

```
# Formula referencing another sheet
=SUM(Sheet2!B2:B100)
=AVERAGE(Data!C2:C100)
=IF(Summary!A1>0, "Positive", "Negative")

# Example:
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Summary",
  cell="B1",
  formula="=SUM(RawData!B2:B1000)"
)
```

### Copying Formulas to Multiple Cells

Once formula is in one cell, copy it to others:

```
# Apply formula to first cell
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=B2*C2*D2"
)

# Copy formula down to all rows
excel_copy_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  source_start="E2",
  source_end="E2",
  target_start="E3"
  # If copying many rows, can specify range:
  # target_end="E1000"
)
```

The formula automatically adjusts row references:
- Row 2: `=B2*C2*D2`
- Row 3: `=B3*C3*D3`
- Row 4: `=B4*C4*D4`
- etc.

### Array Formulas

For advanced calculations:

```
# Sum with condition
=SUMIF(A2:A100, "Active", B2:B100)

# Average with condition  
=AVERAGEIF(A2:A100, ">100")

# Count with multiple conditions
=COUNTIFS(A2:A100, "North", B2:B100, ">50000")
```

---

## Practical Formatting Examples

### Professional Report Header

```
# Create multi-level header
# Row 1: Title (merged)
excel_merge_cells(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="A1",
  end_cell="F1"
)
excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Report",
  data=[["Quarterly Financial Report - Q1 2025"]],
  start_cell="A1"
)
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="A1",
  end_cell="F1",
  bold=true,
  font_size=16,
  alignment="center",
  bg_color="#0066CC",
  font_color="#FFFFFF"
)

# Row 2: Subtitle
excel_merge_cells(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="A2",
  end_cell="F2"
)
excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Report",
  data=[["Prepared: January 28, 2025"]],
  start_cell="A2"
)
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="A2",
  end_cell="F2",
  italic=true,
  alignment="center",
  font_color="#666666"
)

# Row 3: Empty
# Row 4: Column headers
excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Report",
  data=[["Region", "Q1 Sales", "Q1 Cost", "Profit", "Margin %", "Trend"]],
  start_cell="A4"
)
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="A4",
  end_cell="F4",
  bold=true,
  bg_color="#CCCCCC",
  alignment="center"
)

# Data rows with appropriate formatting
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="B5",
  end_cell="D100",
  number_format="$#,##0",
  alignment="right"
)
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Report",
  start_cell="E5",
  end_cell="E100",
  number_format="0.00%",
  alignment="right"
)
```

### Alternating Row Colors

```
# For visual clarity, format alternate rows
# Light rows
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A5",
  end_cell="D5",
  bg_color="#FFFFFF"
)
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A7",
  end_cell="D7",
  bg_color="#FFFFFF"
)

# Slightly gray rows
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A6",
  end_cell="D6",
  bg_color="#F2F2F2"
)
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A8",
  end_cell="D8",
  bg_color="#F2F2F2"
)
```

---

**Cell Operations Guide Version**: 1.0
**Last Updated**: 2025-01-28
