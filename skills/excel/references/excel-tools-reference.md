# Excel Tools Reference

Complete reference documentation for all Excel MCP server tools.

## File Operations

### excel_create_workbook
**Purpose**: Create a new Excel workbook file

**Parameters**:
- `filepath` (string, required): Absolute path where workbook will be created (must end in .xlsx)

**Returns**: Success confirmation

**Example**:
```
excel_create_workbook(filepath="/home/user/data.xlsx")
```

**Common errors**:
- Invalid path or filename
- Directory doesn't exist
- File already exists (will overwrite)

**Best practice**: Always use absolute paths, check directory exists first

---

### excel_read_data_from_excel
**Purpose**: Read data from a worksheet with cell metadata

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `sheet_name` (string, required): Name of worksheet
- `start_cell` (string, optional): Cell to start reading (default: A1)
- `end_cell` (string, optional): Cell to end reading (auto-expands if omitted)
- `preview_only` (boolean, optional): Return sample only (default: false)

**Returns**: JSON with cell data including:
- Cell address (e.g., "A1")
- Value
- Row number
- Column number
- Validation metadata (if any)

**Example**:
```
# Preview first
excel_read_data_from_excel(
  filepath="/data.xlsx",
  sheet_name="Sales",
  preview_only=true
)

# Then read full range
excel_read_data_from_excel(
  filepath="/data.xlsx",
  sheet_name="Sales",
  start_cell="A1",
  end_cell="Z1000",
  preview_only=false
)
```

**Best practice**: Always use preview_only=true first on unknown data

---

### excel_write_data_to_excel
**Purpose**: Write data to worksheet (batch operation)

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `sheet_name` (string, required): Name of worksheet
- `data` (array of arrays, required): Data rows to write
- `start_cell` (string, optional): Starting cell (default: A1)

**Returns**: Success confirmation with dimensions written

**Example**:
```
excel_write_data_to_excel(
  filepath="/data.xlsx",
  sheet_name="Import",
  data=[
    ["Name", "Age", "Department"],
    ["Alice", 30, "Sales"],
    ["Bob", 28, "Engineering"],
    ["Carol", 35, "Management"]
  ],
  start_cell="A1"
)
```

**Best practice**: Use for batch operations, not individual cells

---

### excel_get_workbook_metadata
**Purpose**: Get information about workbook structure

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `include_ranges` (boolean, optional): Include range info (default: false)

**Returns**: JSON with:
- Sheet names
- Ranges (if requested)
- Workbook properties

**Example**:
```
excel_get_workbook_metadata(
  filepath="/data.xlsx",
  include_ranges=true
)

# Returns something like:
{
  "sheets": ["Sheet1", "Data", "Summary"],
  "ranges": {...}
}
```

**Best practice**: Use to verify sheet names before operations

---

### excel_copy_range
**Purpose**: Copy cells from one location to another

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `sheet_name` (string, required): Source worksheet
- `source_start` (string, required): Starting cell (e.g., "A1")
- `source_end` (string, required): Ending cell (e.g., "D10")
- `target_start` (string, required): Destination cell
- `target_sheet` (string, optional): Destination sheet (default: same sheet)

**Returns**: Success confirmation

**Example**:
```
# Copy within same sheet
excel_copy_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  source_start="A1",
  source_end="D10",
  target_start="A15"
)

# Copy to different sheet
excel_copy_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  source_start="A1",
  source_end="D10",
  target_start="A1",
  target_sheet="Backup"
)
```

**Best practice**: Copies formatting and formulas along with data

---

### excel_delete_range
**Purpose**: Delete cells and shift remaining cells

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `sheet_name` (string, required): Worksheet name
- `start_cell` (string, required): Starting cell to delete
- `end_cell` (string, required): Ending cell to delete
- `shift_direction` (string, optional): "up" or "left" (default: "up")

**Returns**: Success confirmation

**Example**:
```
# Delete rows (shift up)
excel_delete_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="A3",
  end_cell="D3",
  shift_direction="up"
)

# Delete columns (shift left)
excel_delete_range(
  filepath="/data.xlsx",
  sheet_name="Data",
  start_cell="C1",
  end_cell="C100",
  shift_direction="left"
)
```

---

## Worksheet Operations

### excel_create_worksheet
**Purpose**: Create a new worksheet in existing workbook

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `sheet_name` (string, required): Name for new worksheet

**Returns**: Success confirmation

**Example**:
```
excel_create_worksheet(
  filepath="/data.xlsx",
  sheet_name="AnalysisQ1"
)
```

---

### excel_rename_worksheet
**Purpose**: Rename existing worksheet

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `old_name` (string, required): Current worksheet name
- `new_name` (string, required): New worksheet name

**Returns**: Success confirmation

**Example**:
```
excel_rename_worksheet(
  filepath="/data.xlsx",
  old_name="Sheet1",
  new_name="SalesData"
)
```

---

### excel_copy_worksheet
**Purpose**: Duplicate a worksheet with or without data

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `source_sheet` (string, required): Worksheet to copy
- `target_sheet` (string, required): Name for new worksheet

**Returns**: Success confirmation

**Example**:
```
excel_copy_worksheet(
  filepath="/data.xlsx",
  source_sheet="Template",
  target_sheet="Q1Data"
)
```

---

### excel_delete_worksheet
**Purpose**: Delete a worksheet

**Parameters**:
- `filepath` (string, required): Path to Excel file
- `sheet_name` (string, required): Worksheet to delete

**Returns**: Success confirmation

**Note**: Cannot delete the last remaining worksheet

---

## Cell Formatting

### excel_format_range
**Purpose**: Apply formatting to cells

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_cell` (string, required)
- `end_cell` (string, optional): If omitted, applies to start_cell only

**Formatting options**:
- `bold` (boolean): Bold text
- `italic` (boolean): Italic text
- `underline` (boolean): Underline text
- `font_size` (integer): Font size in points
- `font_color` (string): Font color (hex or name)
- `bg_color` (string): Background color (hex or name)
- `alignment` (string): "left", "center", "right"
- `wrap_text` (boolean): Wrap text in cell
- `number_format` (string): Number format code
- `border_style` (string): Border style
- `border_color` (string): Border color

**Example**:
```
excel_format_range(
  filepath="/data.xlsx",
  sheet_name="Report",
  start_cell="A1",
  end_cell="D1",
  bold=true,
  bg_color="#003366",
  font_color="#FFFFFF",
  alignment="center"
)
```

---

### excel_merge_cells
**Purpose**: Merge a range of cells

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_cell` (string, required)
- `end_cell` (string, required)

**Returns**: Success confirmation

**Example**:
```
excel_merge_cells(
  filepath="/data.xlsx",
  sheet_name="Report",
  start_cell="A1",
  end_cell="D1"
)
```

---

### excel_unmerge_cells
**Purpose**: Unmerge a range of cells

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_cell` (string, required)
- `end_cell` (string, required)

**Returns**: Success confirmation

---

### excel_get_merged_cells
**Purpose**: List all merged cell ranges in worksheet

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)

**Returns**: Array of merged cell ranges

---

## Cell Operations

### excel_apply_formula
**Purpose**: Apply a formula to a cell

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `cell` (string, required): Target cell (e.g., "E1")
- `formula` (string, required): Excel formula (must start with =)

**Returns**: Success confirmation with formula reference

**Example**:
```
excel_apply_formula(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=SUM(B2:D2)"
)
```

**Common formulas**:
- `=SUM(range)` - Sum values
- `=AVERAGE(range)` - Calculate average
- `=COUNT(range)` - Count cells
- `=IF(condition, true_val, false_val)` - Conditional
- `=VLOOKUP(lookup_val, table, col_idx)` - Lookup
- `=CONCATENATE(A1, B1)` - Combine text

---

### excel_validate_formula_syntax
**Purpose**: Check formula syntax without applying

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `cell` (string, required)
- `formula` (string, required)

**Returns**: Validation result with any syntax errors

**Example**:
```
excel_validate_formula_syntax(
  filepath="/data.xlsx",
  sheet_name="Data",
  cell="E2",
  formula="=SUM(B2:D2)"
)
```

---

## Tables and Ranges

### excel_create_table
**Purpose**: Convert a range into an Excel table

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `data_range` (string, required): Range to convert (e.g., "A1:D10")
- `table_name` (string, optional): Name for table
- `table_style` (string, optional): Style name (default: "TableStyleMedium9")

**Returns**: Success confirmation with table name

**Example**:
```
excel_create_table(
  filepath="/data.xlsx",
  sheet_name="Sales",
  data_range="A1:D100",
  table_name="SalesData",
  table_style="TableStyleMedium9"
)
```

---

### excel_validate_excel_range
**Purpose**: Validate that a range is properly formatted

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_cell` (string, required)
- `end_cell` (string, optional)

**Returns**: Validation result

---

### excel_insert_rows
**Purpose**: Insert blank rows at specified position

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_row` (integer, required): Row number (1-based)
- `count` (integer, optional): Number of rows (default: 1)

**Returns**: Success confirmation

---

### excel_insert_columns
**Purpose**: Insert blank columns at specified position

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_col` (integer, required): Column number (1-based)
- `count` (integer, optional): Number of columns (default: 1)

**Returns**: Success confirmation

---

### excel_delete_sheet_rows
**Purpose**: Delete rows and shift remaining cells up

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_row` (integer, required): Row number to start deletion
- `count` (integer, optional): Number of rows to delete (default: 1)

**Returns**: Success confirmation

---

### excel_delete_sheet_columns
**Purpose**: Delete columns and shift remaining cells left

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `start_col` (integer, required): Column number to start deletion
- `count` (integer, optional): Number of columns to delete (default: 1)

**Returns**: Success confirmation

---

## Advanced Features

### excel_create_chart
**Purpose**: Create a chart from data range

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `data_range` (string, required): Data for chart (e.g., "A1:C10")
- `chart_type` (string, required): Type of chart
- `target_cell` (string, required): Where to place chart
- `title` (string, optional): Chart title
- `x_axis` (string, optional): X-axis label
- `y_axis` (string, optional): Y-axis label

**Chart types**: bar, line, pie, scatter, area, column, doughnut, bubble, etc.

**Example**:
```
excel_create_chart(
  filepath="/data.xlsx",
  sheet_name="Report",
  data_range="A1:B10",
  chart_type="bar",
  target_cell="D1",
  title="Sales by Region",
  x_axis="Region",
  y_axis="Sales"
)
```

---

### excel_create_pivot_table
**Purpose**: Create a pivot table for data summary

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)
- `data_range` (string, required): Source data
- `rows` (array, required): Field names for rows
- `columns` (array, optional): Field names for columns
- `values` (array, required): Fields to aggregate
- `agg_func` (string, optional): Aggregation function (default: "mean")
  - Options: sum, mean, count, min, max, product, etc.

**Example**:
```
excel_create_pivot_table(
  filepath="/data.xlsx",
  sheet_name="Raw",
  data_range="A1:D100",
  rows=["Region"],
  columns=["Month"],
  values=["Sales"],
  agg_func="sum"
)
```

---

### excel_get_data_validation_info
**Purpose**: List all data validation rules in worksheet

**Parameters**:
- `filepath` (string, required)
- `sheet_name` (string, required)

**Returns**: Array of validation rules with cell ranges

---

## Summary of Tool Count
- **File Operations**: 6 tools
- **Worksheet Operations**: 4 tools
- **Cell Formatting**: 4 tools
- **Cell Operations**: 2 tools
- **Tables and Ranges**: 7 tools
- **Advanced Features**: 3 tools

**Total**: 26 tools available through Excel MCP server

---

**Reference Version**: 1.0
**Last Updated**: 2025-01-28
