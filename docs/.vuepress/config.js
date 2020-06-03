module.exports = {
    title: "Commercio.network Dart SDK Documentation",
    description: "Documentation for the Commercio.network blockhain Dart SDK.",
    head: [
        ['link', {
            rel: "commercio-icon",
            href: "/.vuepress/icon.png"
        }]
    ],
    markdown: {
        lineNumbers: true,
    },
    themeConfig: {
        repo: "commercionetwork/commercio-sdk.dart",
        editLinks: true,
        docsDir: "docs",
        docsBranch: "master",
        editLinkText: "Edit this page on Github",
        lastUpdated: true,
        nav: [{
            text: "Commercio.network",
            link: "https://commercio.network"
        }, ],
        sidebarDepth: 2,
        sidebar: [{
                title: "Wallet",
                collapsable: true,
                children: [
                    ["wallet/create-wallet", "Create a wallet"],
                ]
            },
            {
                title: "Id helpers",
                collapsable: true,
                children: [
                    ["lib/id/id_helper", "Id"],
                    ["lib/id/did_document_helper", "Did Document"],
                    ["lib/id/request_did_power_up_helper", "Request Did PowerUp"]
                ]
            },
            {
                title: "Docs helpers",
                collapsable: true,
                children: [
                    ["lib/docs/docs_helper", "Docs"],
                    ["lib/docs/commercio_doc_helper", "Commercio Doc"],
                    ["lib/docs/commercio_doc_receipt_helper", "Commercio Doc Receipt"]
                ]
            },
            {
                title: "Membership helpers",
                collapsable: true,
                children: [
                    ["lib/membership/membership_helper", "Membership"],
                    ["lib/membership/buy_membership_helper", "Buy Membership"],
                    ["lib/membership/invite_user_helper", "Invite User"]
                ]
            },
            {
                title: "Mint helpers",
                collapsable: true,
                children: [
                    ["lib/mint/mint_helper", "Mint helper"],
                    ["lib/mint/open_cdp_helper", "Open Cdp helper"],
                    ["lib/mint/close_cdp_helper", "Close Cdp helper"]
                ]
            },
            {
                title: "Tx helpers",
                collapsable: true,
                children: [
                    ["lib/tx/tx_helper", "Tx helper"]
                ]
            },
            {
                title: "Sign helpers",
                collapsable: true,
                children: [
                    ["lib/crypto/sign_helper", "Sign Helper"]
                ]
            },
            {
                title: "Utility helpers",
                collapsable: true,
                children: [
                    ["lib/crypto/keys_helper", "Keys Helper"],
                    ["lib/crypto/encryption_helper", "Encryption helper"]
                ]
            },
            {
                title: "Glossary",
                collapsable: true,
                children: [
                    ["lib/glossary", "Glossary"]
                ]
            }
        ]
    }
};