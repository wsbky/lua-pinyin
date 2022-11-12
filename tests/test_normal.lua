local test = {
    {
        input = "Han4yu3",
        expected = "Hànyǔ"
    },
    {
        input = "shang1 liang",
        expected = "shāng liang"
    },
    {
        input = "shang1 liang shang liang",
        expected = "shāng liang shang liang"
    },
}

return {
    test = test,
}
