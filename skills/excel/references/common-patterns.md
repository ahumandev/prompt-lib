# Common Excel Patterns

Real-world patterns for typical Excel operations tasks.

## Pattern 1: Data Import Pipeline

**Scenario**: Import data from external source into structured Excel file

**Steps**:
1. Create new workbook for import
2. Create worksheet for raw data
3. Write raw data to worksheet
4. Create second worksheet for processed data
5. Add formulas to transform/clean data
6. Create summary worksheet with pivot table

**Tools used**:
- `excel_create_workbook`
- `excel_create_worksheet`
- `excel_write_data_to_excel`
- `excel_apply_formula`
- `excel_create_pivot_table`

**Example workflow**:
```
# Step 1: Create structure
excel_create_workbook(filepath="/import.xlsx")
excel_create_worksheet(filepath="/import.xlsx", sheet_name="Raw")
excel_create_worksheet(filepath="/import.xlsx", sheet_name="Cleaned")
excel_create_worksheet(filepath="/import.xlsx", sheet_name="Summary")

# Step 2: Import raw data
excel_write_data_to_excel(
  filepath="/import.xlsx",
  sheet_name="Raw",
  data=[[raw_data_rows]],
  start_cell="A1"
)

# Step 3: Add cleaning formulas
excel_apply_formula(
  filepath="/import.xlsx",
  sheet_name="Cleaned",
  cell="A2",
  formula="=TRIM(Raw!A2)"  # Remove extra spaces
)

# Step 4: Create summary
excel_create_pivot_table(
  filepath="/import.xlsx",
  sheet_name="Raw",
  data_range="A1:D1000",
  rows=["Category"],
  values=["Amount"],
  agg_func="sum"
)
```

---

## Pattern 2: Report Generation with Formatting

**Scenario**: Create professional-looking report with headers, formatting, and totals

**Steps**:
1. Create workbook
2. Create title section (merged cells)
3. Add column headers with formatting
4. Write data rows
5. Add summary row with formulas
6. Format entire range for presentation

**Tools used**:
- `excel_create_workbook`
- `excel_write_data_to_excel`
- `excel_merge_cells`
- `excel_format_range`
- `excel_apply_formula`

**Example workflow**:
```
# Create structure
excel_create_workbook(filepath="/report.xlsx")

# Title (merged, centered, large)
excel_merge_cells(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1"
)
excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  data=[["Q1 Sales Report"]],
  start_cell="A1"
)
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  bold=true,
  font_size=16,
  alignment="center",
  bg_color="#0066CC",
  font_color="#FFFFFF"
)

# Headers
excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  data=[["Region", "Sales", "Growth", "Target"]],
  start_cell="A3"
)
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  start_cell="A3",
  end_cell="D3",
  bold=true,
  bg_color="#CCCCCC"
)

# Data rows
excel_write_data_to_excel(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  data=[
    ["North", 150000, 0.12, 140000],
    ["South", 120000, 0.08, 130000],
    ["East", 180000, 0.15, 160000],
    ["West", 160000, 0.11, 150000]
  ],
  start_cell="A4"
)

# Total row with formulas
excel_apply_formula(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  cell="A8",
  formula="Total"
)
excel_apply_formula(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  cell="B8",
  formula="=SUM(B4:B7)"
)
excel_apply_formula(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  cell="C8",
  formula="=AVERAGE(C4:C7)"
)

# Format total row
excel_format_range(
  filepath="/report.xlsx",
  sheet_name="Sheet1",
  start_cell="A8",
  end_cell="D8",
  bold=true,
  bg_color="#FFFF99"
)
```

---

## Pattern 3: Data Validation Setup

**Scenario**: Create spreadsheet with validation rules (dropdown lists)

**Steps**:
1. Create workbook with headers
2. Define valid values (in separate sheet or inline)
3. Apply data validation to data columns
4. Add filtering/sorting for ease of use

**Tools used**:
- `excel_create_workbook`
- `excel_create_worksheet`
- `excel_write_data_to_excel`
- `excel_format_range`
- `excel_get_data_validation_info`

**Example workflow**:
```
# Create structure
excel_create_workbook(filepath="/form.xlsx")
excel_create_worksheet(filepath="/form.xlsx", sheet_name="Lists")

# Define valid values in separate sheet
excel_write_data_to_excel(
  filepath="/form.xlsx",
  sheet_name="Lists",
  data=[
    ["Regions"],
    ["North"],
    ["South"],
    ["East"],
    ["West"]
  ],
  start_cell="A1"
)

# Headers in main sheet
excel_write_data_to_excel(
  filepath="/form.xlsx",
  sheet_name="Sheet1",
  data=[["Date", "Region", "Amount", "Notes"]],
  start_cell="A1"
)

# Format headers
excel_format_range(
  filepath="/form.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="D1",
  bold=true,
  bg_color="#0066CC",
  font_color="#FFFFFF"
)

# Create table for data entry
excel_create_table(
  filepath="/form.xlsx",
  sheet_name="Sheet1",
  data_range="A1:D100",
  table_name="DataEntry"
)

# Note: Validation would be set through additional API calls
# or defined in Excel directly
```

---

## Pattern 4: Multi-Sheet Report

**Scenario**: Create report with multiple sheets for different sections

**Steps**:
1. Create workbook
2. Create multiple worksheets for each section
3. Add data to each sheet
4. Create summary sheet that references other sheets
5. Add formulas that pull from other sheets
6. Format consistently across sheets

**Tools used**:
- `excel_create_workbook`
- `excel_create_worksheet`
- `excel_write_data_to_excel`
- `excel_apply_formula`
- `excel_format_range`
- `excel_rename_worksheet`

**Example workflow**:
```
# Create workbook
excel_create_workbook(filepath="/analysis.xlsx")

# Create sheets for each product line
excel_create_worksheet(filepath="/analysis.xlsx", sheet_name="Products")
excel_rename_worksheet(
  filepath="/analysis.xlsx",
  old_name="Sheet1",
  new_name="Electronics"
)

# Add data to Electronics sheet
excel_write_data_to_excel(
  filepath="/analysis.xlsx",
  sheet_name="Electronics",
  data=[
    ["Product", "Q1", "Q2", "Q3", "Q4"],
    ["Laptops", 50000, 52000, 55000, 60000],
    ["Phones", 80000, 85000, 90000, 95000],
    ["Tablets", 30000, 32000, 35000, 38000]
  ],
  start_cell="A1"
)

# Create summary sheet
excel_create_worksheet(filepath="/analysis.xlsx", sheet_name="Summary")

# Add summary data with formulas
excel_write_data_to_excel(
  filepath="/analysis.xlsx",
  sheet_name="Summary",
  data=[["Department", "Total Sales", "Growth"]],
  start_cell="A1"
)

excel_apply_formula(
  filepath="/analysis.xlsx",
  sheet_name="Summary",
  cell="B2",
  formula="=SUM(Electronics!B2:E4)"
)

# Cross-sheet formulas can reference: SheetName!CellRange
```

---

## Pattern 5: Efficient Batch Processing

**Scenario**: Process large dataset with formulas without individual cell operations

**Steps**:
1. Prepare data in single write operation
2. Set up formula in first cell
3. Copy formula down to all rows in one operation
4. Format entire range at once
5. Verify results

**Tools used**:
- `excel_write_data_to_excel`
- `excel_apply_formula`
- `excel_copy_range`
- `excel_format_range`
- `excel_read_data_from_excel`

**Example workflow**:
```
# Write all data at once (not row by row)
excel_write_data_to_excel(
  filepath="/data.xlsx",
  sheet_name="Processing",
  data=[[all_rows]],  # Array of all rows
  start_cell="A1"
)

# Add formula to first data row
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Processing",
  cell="D2",
  formula="=B2*C2"  # Multiply columns B and C
)

# Copy formula down to all rows efficiently
excel_copy_range(
  filepath="/data.xlsx",
  sheet_name="Processing",
  source_start="D2",
  source_end="D2",
  target_start="D3",
  target_sheet="Processing"
)
# Then copy to entire range

# Format all at once
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Processing",
  start_cell="D2",
  end_cell="D10000",
  number_format="$#,##0.00"
)

# Verify sample
excel_read_data_from_excel(
  filepath="/data.xlsx",
  sheet_name="Processing",
  start_cell="D2",
  end_cell="D10",
  preview_only=false
)
```

---

## Pattern 6: Template-Based Report

**Scenario**: Use template workbook to generate multiple reports with same structure

**Steps**:
1. Create template workbook with structure/formatting
2. Copy template for each report
3. Update data in new workbook
4. Keep formatting from template

**Tools used**:
- `excel_create_workbook`
- `excel_copy_worksheet`
- `excel_write_data_to_excel`
- `excel_rename_worksheet`

**Example workflow**:
```
# First time: Create template
excel_create_workbook(filepath="/template.xlsx")
excel_write_data_to_excel(
  filepath="/template.xlsx",
  sheet_name="Sheet1",
  data=[["Report Header"], ["Item", "Amount", "Date"]],
  start_cell="A1"
)
# Format template nicely
excel_format_range(
  filepath="/template.xlsx",
  sheet_name="Sheet1",
  start_cell="A1",
  end_cell="C1",
  bold=true,
  bg_color="#003366",
  font_color="#FFFFFF"
)

# For each new report:
# Step 1: Create new workbook from template (copy it)
excel_copy_worksheet(
  filepath="/template.xlsx",
  source_sheet="Sheet1",
  target_sheet="ReportJan"
)

# Step 2: Update data (formatting preserved)
excel_write_data_to_excel(
  filepath="/template.xlsx",
  sheet_name="ReportJan",
  data=[[data_for_january]],
  start_cell="A3"
)
```

---

## Pattern 7: Data Cleanup and Standardization

**Scenario**: Import messy data and clean it with formulas

**Uses**: TRIM, UPPER, LOWER, CONCATENATE, etc.

**Steps**:
1. Import raw data into "Raw" sheet
2. Create "Clean" sheet
3. Add formulas to clean/standardize each column
4. Review results
5. Copy cleaned values back if needed

**Example formulas**:
```
# Remove extra spaces
=TRIM(Raw!A2)

# Convert to uppercase
=UPPER(Raw!B2)

# Combine first and last name
=CONCATENATE(Raw!B2, " ", Raw!C2)

# Extract year from date
=YEAR(Raw!D2)

# Convert text to number
=VALUE(Raw!E2)

# Check for missing values
=IF(ISBLANK(Raw!F2), "MISSING", "OK")
```

---

## Pattern 8: Dashboard with Charts

**Scenario**: Create interactive dashboard with multiple visualizations

**Steps**:
1. Prepare data ranges
2. Create separate sheet for dashboard
3. Add multiple charts with different data
4. Format and arrange charts
5. Add summary statistics with formulas

**Tools used**:
- `excel_create_chart`
- `excel_apply_formula`
- `excel_format_range`
- `excel_create_worksheet`

**Example workflow**:
```
# Create Dashboard sheet
excel_create_worksheet(filepath="/dashboard.xlsx", sheet_name="Dashboard")

# Add summary metrics
excel_apply_formula(
  filepath="/dashboard.xlsx",
  sheet_name="Dashboard",
  cell="B2",
  formula="=SUM(Data!B:B)"
)

# Create charts
excel_create_chart(
  filepath="/dashboard.xlsx",
  sheet_name="Data",
  data_range="A1:B12",
  chart_type="line",
  target_cell="Dashboard!A1",
  title="Sales Trend"
)

excel_create_chart(
  filepath="/dashboard.xlsx",
  sheet_name="Data",
  data_range="A1:C12",
  chart_type="pie",
  target_cell="Dashboard!A15",
  title="Market Share"
)
```

---

## Pattern 9: Conditional Formatting Rules

**Scenario**: Apply formatting based on values (highlights, color scales)

**Uses**: Format cells with specific conditions

**Example**:
```
# Highlight high values in red
# Can be done through conditional_format parameter in excel_format_range
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  conditional_format={
    "type": "colorScale",
    "minColor": "#FFFFFF",
    "maxColor": "#FF0000"
  }
)

# Or highlight specific values
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="B2",
  end_cell="B1000",
  conditional_format={
    "type": "formula",
    "criteria": "B2>1000",
    "bg_color": "#FFFF00"
  }
)
```

---

## Anti-Patterns (What NOT to Do)

### ❌ Anti-Pattern 1: Writing one cell at a time
```
# BAD: Loops cause performance issues
for row in data:
  excel_write_data_to_excel(filepath, sheet, data=[[row]], start_cell=...)

# GOOD: Write all at once
excel_write_data_to_excel(filepath, sheet, data=data, start_cell="A1")
```

### ❌ Anti-Pattern 2: Applying formulas individually
```
# BAD: Slow and error-prone
for i in range(1, 1000):
  excel_apply_formula(filepath, sheet, cell=f"E{i}", formula="=B{i}*C{i}")

# GOOD: Apply once and copy
excel_apply_formula(filepath, sheet, cell="E2", formula="=B2*C2")
excel_copy_range(filepath, sheet, source_start="E2", source_end="E2", 
                 target_start="E3")
```

### ❌ Anti-Pattern 3: Not previewing large files
```
# BAD: No idea what data looks like
excel_read_data_from_excel(filepath, sheet, start_cell="A1", end_cell="ZZ100000")

# GOOD: Preview first
excel_read_data_from_excel(filepath, sheet, preview_only=true)
# Then if structure looks right:
excel_read_data_from_excel(filepath, sheet, start_cell="A1", end_cell="D1000")
```

### ❌ Anti-Pattern 4: Applying formulas without validation
```
# BAD: Syntax errors
excel_apply_formula(filepath, sheet, cell="E2", formula="=SUM(B2:D2)")

# GOOD: Validate first
excel_validate_formula_syntax(filepath, sheet, cell="E2", formula="=SUM(B2:D2)")
excel_apply_formula(filepath, sheet, cell="E2", formula="=SUM(B2:D2)")
```

---

**Pattern Collection Version**: 1.0
**Last Updated**: 2025-01-28
