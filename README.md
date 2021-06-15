# Generate/Compress Thumbnails

This action runs a shell script `entrypoint.sh` file which will expect a folder with images as well as the width you want your thumbnails to be. It will then compress them, and resize them to a specific width (It will automatically calculate the height proportionately).

# Running this action

1. Go to your repo
2. Click on the **Actions** tab
3. Click on the **Set up a workflow yourself** link
4. Use the following script.

```yaml
name: Generate Thumbnails
on:
  workflow_dispatch:
jobs:
  copy-to-branches:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/setup-node@v2
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Generate Thumbnails Task
        uses: planetoftheweb/generate-thumbnails
        env:
          directory: photos
          width: 500
```

5. Click the **Start commit** button
6. Click back on the **Actions** tab
7. Click on the **Generate Thumbnails** workflow
8. Click on **Run Workflow**

The workflow should run automatically, you can monitor it if you want to.
