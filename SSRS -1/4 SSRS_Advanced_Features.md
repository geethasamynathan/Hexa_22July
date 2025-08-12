
# SSRS Advanced Features – Grouping, Lists, Visualizations, Sub-Reports, Maps & Deployment

## 1. Advanced Grouping and Toggle Visibility

### Concept
- Grouping allows you to organize data into logical sections.
- Toggle visibility creates an expand/collapse (+/-) experience similar to Excel pivot tables.

### Steps – Creating Toggle Visibility in Groups
1. Create a Matrix or Table report.
2. Group rows/columns based on a field (e.g., Name or CountryRegionCode).
3. Right-click the group → Group Properties.
4. Go to Visibility:
   - Select Hide by default.
   - Enable Display can be toggled by this report item → select the parent field (e.g., Name).
5. Preview report:
   - You’ll see + signs to expand/collapse grouped rows or columns.

**Use Case Example**:  
- CountryRegionCode as a parent group with SalesYTD details hidden by default.  
- Expand country to view each territory’s sales.

---

## 2. Using Lists in SSRS

### Purpose
- Lists provide a template layout repeated for each dataset row/group.
- Fully customizable — can include text boxes, rectangles, charts, images, sub-reports, etc.

### Steps to Create a List
1. Insert List control from Toolbox.
2. Assign Dataset to the list.
3. Set grouping:
   - Right-click list → Group Properties → Group on field (e.g., TerritoryID).
4. Add content inside list:
   - Text box for field labels & values.
   - Rectangles for background styling.
   - Tables, matrices, or charts for related details.
5. Format for readability (fonts, colors, alignment).

**Example**:
- A Scorecard report where each list section contains performance data for one employee, formatted for printing.

---

## 3. Combining Lists with Other Controls
- Inside a list, you can insert:
  - Matrix/Table for detail rows.
  - Charts for graphical summaries.
  - Images for branding or employee pictures.
- Each list section becomes a mini-dashboard for a single data group.

---

## 4. Visualization in SSRS

### Available Chart Types
- Bar, Column, Line, Area, Pie, Scatter, Gauge, Sparkline.
- Supports 2D & 3D rendering.

### Example – Creating a Bar Chart
1. Insert chart → Select Bar Chart.
2. Assign Dataset.
3. Set Category Groups (X-axis) → e.g., CountryRegionCode.
4. Set Values (Y-axis) → e.g., SalesYTD.
5. Format:
   - Change axis properties to currency (Vertical Axis Properties → Number → Currency).
   - Add data labels for readability.

**Example – Creating a Pie Chart**
- Category Group → Group field.
- Values → SalesYTD.
- Add data labels to show percentages or actual values.

---

## 5. Sub-Reports in SSRS

### Concept
- A sub-report is a report embedded inside another report (like an HTML iframe).
- Used for drill-down, detail-on-demand, or modular report design.

### Steps – Creating Parent & Sub-Report
1. Create Sub-Report:
   - Dataset with a parameter (e.g., WHERE CountryRegionCode = @CountryRegionCode).
   - Table or Matrix to display filtered data.
2. Create Parent Report:
   - Dataset listing higher-level items (e.g., list of countries).
   - Insert a Sub-Report control.
   - Set Sub-Report properties:
     - Link to sub-report name.
     - Pass parent field as parameter.
3. Preview:
   - For each parent row, the sub-report displays related details.

**Use Case**:
- Parent: Countries list.
- Sub-Report: Territory and sales breakdown for selected country.

---

## 6. Maps in SSRS

### Purpose
- Visualize spatial/geographic data using Map Control.
- Supports integration with Bing Maps or custom shapefiles (.shp).

### Steps – Creating a Map
1. Create Dataset with spatial data (e.g., geography type in SQL Server).
2. Insert Map from Toolbox.
3. Choose:
   - Map Gallery (preloaded USA/world maps).
   - ESRI Shapefile (custom map regions).
   - SQL Server spatial query.
4. Assign Dataset and spatial field.
5. Optionally add Bing Maps layer for satellite/road imagery.
6. Choose visualization type:
   - Basic marker map.
   - Bubble map (size based on data value).
   - Color-coded polygons.

**Example**:
- Map with store locations as pushpins.
- Color intensity based on sales performance.

---

## 7. Deployment of SSRS Reports

### Configuring Target Server
- Right-click Solution → Properties.
- Set TargetServerURL:
  - Local: http://localhost/ReportServer or http://localhost/ReportServer_INSTANCE
  - Remote: http://<serverName>/ReportServer

### Deployment Steps
1. Deploy Shared Data Sources first.
2. Deploy reports.
3. Verify in Web Portal (http://localhost/Reports).
4. Manage in portal:
   - Create folders.
   - Set permissions.
   - Share URLs with users.

---

## 8. Tips & Best Practices
- Use Shared Data Sources for consistency across reports.
- Apply parameters to create dynamic filtering and drill-down experiences.
- Combine lists, charts, and sub-reports for dashboard-style reporting.
- For large datasets, leverage server-side filtering in SQL.
- Optimize performance with report caching and snapshots.
