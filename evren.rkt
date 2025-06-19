#lang racket
(require "teachpacks/evren-teachpack.rkt")

(define BACKGROUND (bitmap "imaj/kutuphane.jpg")) 

(define FRAME-RATE 12)


;; STRUCT v - vektör
;; x : sayı - x koordinatı
;; y : sayı - y koordinatı
(STRUCT v (x y))


;; v+ - vektör toplama
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v- - vektör çıkartma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v* - vektör sayıyla çarpma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v. - vektör dot çarpma
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;; v-mag - vektör uzunluğu
;; 
;;
;(ÖRNEK ....)
;(ÖRNEK ....)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hediye vektör çizim fonksiyonları
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;place-image/v
;; resim v sahne -> sahne
;; bir sahneye vectöre göre bir imaj yerleştir
;; template :
;; (define (place-image/v im v1 sahne)
;;  (... im ... (v-x v1) ... (v-y v1) ...)
(define test-circle (circle 10 "solid" "purple"))
(define test-square (square 100 "solid" "green"))

(ÖRNEK (place-image/v  test-circle (v 5 5) test-square)
       (place-image/align test-circle 5 5 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 3 8) test-square)
       (place-image/align test-circle 3 8 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 1 2) test-square)
       (place-image/align test-circle 1 2 "center" "center" test-square))
(ÖRNEK (place-image/v test-circle (v 2 8) test-square)
       (place-image/align test-circle 2 8 "center" "center" test-square))

(define (place-image/v im v1 sahne)
  (place-image/align im (v-x v1) (v-y v1) "center" "center"  sahne))

; place-line/v v v color görüntü -> görüntü
; v1'den v2'e giden bir çizgi arka imajına yerleştir
(ÖRNEK (place-line/v (v 2 3) (v 5 1) "red" test-square)
       (add-line test-square 2 3 5 1 "red")) 

(define (place-line/v v1 v2 renk arka)
  (add-line arka (v-x v1) (v-y v1) (v-x v2) (v-y v2) renk)) 

; place-text/v v metin sayı color görüntü -> görüntü
; v pozisyonda  verilen metni arka imajına yerleştir
(ÖRNEK (place-text/v (v 20 30) "Hello" 15 "red" test-square)
       (place-image/v (text "Hello" 15 "red") (v 20 30) test-square))
(define (place-text/v v metin size col arka)
  (place-image/v (text metin size col) v arka))


; STRUCT nesne
;; imaj : görüntü - nesnenin imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi
(STRUCT nesne (imaj yer hız ivme))

(define (nesne-güncelle n)
  n)
  
  
(define (nesne-çiz n b)
  (place-image/v (nesne-imaj n) (nesne-yer n) b))

;; STRUCT evren (-oyununa göre değişecek)
;; arkaplanı : görüntü - oyun arka planı
;;
(STRUCT evren (arkaplanı nesne-a nesne-b nesne-c))

(define (evren-güncelle e)
  (evren
   (evren-arkaplanı e)
   (nesne-güncelle (evren-nesne-a e))
   (nesne-güncelle (evren-nesne-b e))
   (nesne-güncelle (evren-nesne-c e))
   ))

(define (evren-çiz e)
  (nesne-çiz (evren-nesne-a e) (nesne-çiz (evren-nesne-b e) (nesne-çiz (evren-nesne-c e) (evren-arkaplanı e)))))


(define (evren-tuş e t)
  e)

(define (evren-fare e x y m)
  e)


(define yaradılış (evren BACKGROUND
                         (nesne (circle 50 "solid" "red") (v 300 600) (v -1 -30) (v 0 1))
                         (nesne (circle 50 "solid" "blue") (v 200 300) (v 1 -25) (v 0 1))
                         (nesne (circle 50 "solid" "green") (v 100 100) (v 2 -35) (v 0 1))))

;; SES herhangbirşey ses-dosyası-metin -> herhangibirşey
;; birinci paramatresini aynen dönsürüyor, sesi çalarak
;(ÖRNEK (SES 0 "ses/bark.wav") 0)

(test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sabit kod bundan sonra                               ;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(yut (big-bang yaradılış
  (on-tick evren-güncelle (/ 1.0 FRAME-RATE))
  (on-draw evren-çiz)
  (on-key evren-tuş)
  (on-mouse evren-fare)))

