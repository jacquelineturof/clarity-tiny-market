;; sip010-token

(impl-trait .sip010-ft-trait.sip010-ft-trait)

;; SIP010 trait on mainnet
;; (impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))

(define-fungible-token amazing-coin u10000)

(define-public (mint (amount uint) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (ft-mint? amazing-coin amount recipient)
    )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
    (begin
        (asserts! (is-eq tx-sender sender) err-owner-only)
        (try! (ft-transfer? amazing-coin amount sender recipient))
        (match memo to-print (print to-print) 0x)
        (ok true)
    )
)

(define-read-only (get-balance (who principal))
    (ok (ft-get-balance amazing-coin who))
)

(define-read-only (get-decimals)
    (ok u2)
)

(define-read-only (get-name)
    (ok "Amazing Coin")
)

(define-read-only (get-symbol)
    (ok "AZC")
)

(define-read-only (get-token-uri)
    (ok none)
)

(define-read-only (get-total-supply)
    (ok (ft-get-supply amazing-coin))
)


