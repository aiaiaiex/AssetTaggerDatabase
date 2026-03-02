# Asset Tagger Database

## Software Prerequisites (Windows)
1. SQL Server 2025
    - Through [SQL Server 2025 Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) to also install:
        - SQL Server Management Studio (SSMS)
        - SQL Server Configuration Manager
    - [tSQLt](https://tsqlt.org/download/tsqlt/) (V1.0.8083.3529) (Database Unit Testing Framework)
2. [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/)
    - Workloads:
        - Data storage and processing
    - Individual components:
        - .NET SDK
3. [Visual Studio Code (VS Code)](https://code.visualstudio.com/Download)
    - Extensions (as recommended in the .code-workspace file):
        - [SQL Server (mssql)](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)
        - [sqlfluff](https://marketplace.visualstudio.com/items?itemName=sqlfluff.vscode-sqlfluff)
4. [Python 3](https://www.python.org/downloads/windows/)
5. [Git](https://git-scm.com/install/windows)

## Installation
1. Terminal
    1. `git clone https://github.com/aiaiaiex/AssetTaggerDatabase.git`
    2. `cd .\AssetTaggerDatabase\`
    3. `python -m venv venv`
    4. `.\venv\Scripts\activate`
    5. `pip install -r requirements.txt`
    6. `deactivate`
2. Visual Studio Community
    1. Click `Open a project or solution`.
        - Open `AssetTaggerDatabase.slnx`.
    2. Publish AssetTaggerDatabase:
        1. Right-click `AssetTaggerDatabase` in `Solution Explorer`.
        2. Click `Publish`.
        3. `Edit` `Target database connection:` with the correct information.
        4. Input `AssetTaggerDatabase` under `Database name:` if needed.
        5. Click `Publish`.
    3. Install tSQLt:
        1. Click `File`.
        2. Hover on `Open`.
        3. Click `File`.
        4. Click `PrepareServer.sql` from the unzipped `tSQLt_V*.zip` file.
        5. Click `Open`.
        6. Click `▶` (`Execute`).
        7. Select your server.
        8. Select `master` next to `Database Name`.
        9. Click `Connect`.
    4. Publish AssetTaggerDatabaseTests:
        1. Right-click `AssetTaggerDatabaseTests` in `Solution Explorer`.
        2. Click `Publish`.
        3. `Edit` `Target database connection:` with the correct information.
        4. Input `AssetTaggerDatabase` under `Database name:` if needed.
        5. Click `Load Values`.
        6. Click `Publish`.
3. Visual Studio Code (VS Code)
    1. Install [SQL Server (mssql)](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) extension.
        1. Click `SQL Server` in `Activity Bar`.
        2. Hover over `CONNECTIONS`:
        3. Click `+` (`Add Connection`):
        4. Fill out `Connection Dialog` with correct information.
            - If connecting to a remote server preferably use an [`IP address`](https://learn.microsoft.com/en-us/sql/sql-server/connect-to-database-engine?view=sql-server-ver17&tabs=sqldb#connect-to-a-default-sql-server-instance-on-the-network-using-tcpip) in the `Server name` section.
        5. Click `Connect`.
    2. Install [sqlfluff](https://marketplace.visualstudio.com/items?itemName=sqlfluff.vscode-sqlfluff) extension.

## tSQLt Basic Usage (Visual Studio Code)
1. Click `SQL Server` in `Activity Bar`.
2. Click server where `AssetDatabaseTests` is.
3. Click `Databases`.
4. Right-click `AssetTaggerDatabaseTests`.
5. Click `New Query`.
6. Type `EXEC tSQLt.RunAll;`.
7. Click `▶` (`Execute Query`).

## SQLFluff Basic Usage (Terminal)
1. `cd {InsertCorrectPathHere}\AssetTaggerDatabase\`
2. `.\venv\Scripts\activate`
3. `sqlfluff fix .`