;; Posts Contract
(define-map posts
  uint
  {
    owner: principal,
    content: (string-utf8 1000),
    image-url: (string-utf8 200),
    created-at: uint,
    likes: uint
  }
)

(define-data-var post-counter uint u0)

(define-public (create-post (content (string-utf8 1000)) (image-url (string-utf8 200)))
  (let ((post-id (var-get post-counter)))
    (map-set posts post-id {
      owner: tx-sender,
      content: content,
      image-url: image-url,
      created-at: block-height,
      likes: u0
    })
    (var-set post-counter (+ post-id u1))
    (ok post-id)
  )
)

(define-read-only (get-post (post-id uint))
  (ok (map-get? posts post-id))
)
