module.exports = {
    title: "Commercio.network Dart SDK Documentation",
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
                title: "Blockchain's Helpers",
                collapsable: false,
                children: [
                    ["lib/id/id_helper", "Id helper"],
                    ["lib/id/did_document_helper", "Did Document helper"],
                    ["lib/docs/docs_helper", "Docs helper"],
                    ["lib/membership/membership_helper", "Membership helper"],
                    ["lib/mint/mint_helper", "Mint helper"],
                    ["lib/tx/tx_helper", "Tx helper"],
                    ["lib/crypto/sign_helper", "Sign Helper"]
                ]
            },
            {
                title: "Utility Helpers",
                collapsable: false,
                children: [
                    ["lib/crypto/keys_helper", "Keys Helper"],
                    ["lib/crypto/encryption_helper", "Encryption helper"]
                ]
            },
            {
                title: "Glossary",
                collapsable:false,
                children: [
                    ["lib/glossary", "Glossary"]
                ]
            }
        ]
    }
};
