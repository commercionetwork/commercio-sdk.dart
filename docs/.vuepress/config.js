module.exports = {
    title: "Commercio.network SDK Documentation",
    description: "Documentation for the Commercio.network blockhain.",
    head: [
        ['link', { rel: "commercio-icon", href: "/.vuepress/icon.png" }]
    ],
    markdown: {
        lineNumbers: true,
    },
    themeConfig: {
        repo: "commercionetwork/sdk.dart",
        editLinks: true,
        docsDir: "docs",
        docsBranch: "master",
        editLinkText: "Edit this page on Github",
        lastUpdated: true,
        nav: [
            {text: "Commercio.network", link: "https://commercio.network"},
        ],
        sidebarDepth: 2,
        sidebar: [
            {
                title: "Wallet",
                collapsable: false,
                children: [
                    ["wallet/create-wallet", "Create a wallet"],
                ]
            },
            {
                title: "Helpers",
                collapsable: false,
                children: [
                    ["lib/crypto/encryption_helper", "Encryption helper"],
                    ["lib/docs/docs_helper", "Docs helper"],
                    ["lib/id/id_helper", "Id helper"],
                    ["lib/membership/membership_helper", "Membership helper"],
                    ["lib/mint/mint_helper", "Mint helper"],
                    ["lib/tx/tx_helper", "Tx helper"],
                ]
            }
        ]
    }
};
