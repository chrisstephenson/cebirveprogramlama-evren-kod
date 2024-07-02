
;;STRUCT anim
;; devamlı : boolean
;; değişim-sıklığı : sayı;
;; zaman : sayı
;; resimler : görüntü listesi
(STRUCT anim (devamlı değişim-sıklığı zaman resimler))

; anim-çiz anim -> görüntü
; bir animden uygun resim seçmek
(define (anim-çiz a)
  (list-ref (anim-resimler a)
            (modulo (quotient (anim-zaman a) (anim-değişim-sıklığı a))
                    ( length (anim-resimler a)))))

;; anim-zaman-güncelle sayı sayı sayı boolean-> sayı
;; zaman, değişim sıklığı resim sayısı devlılığından yeni zaman hesaplar 
(ÖRNEK (anim-zaman-güncelle 11 3 4 true) 0)
(ÖRNEK (anim-zaman-güncelle 11 3 4 false) 11)
(define (anim-zaman-güncelle z sık uzun devam)
  (cond
    (devam (modulo (+ z 1) (* sık uzun)))
    (else (min (+ z 1) (- (* sık uzun) 1)))))



; anim-güncelle anim -> anim
; bir animden bir sonraki anim yapmak
(define (anim-güncelle a)
  (anim
   (anim-devamlı a)
   (anim-değişim-sıklığı a)
   (anim-zaman-güncelle (anim-zaman a) (anim-değişim-sıklığı a) ( length (anim-resimler a))
                        (anim-devamlı a))
   (anim-resimler a))) 


;;UNION tipi imaj - ya görüntü ya anim
;; imaj->görüntü    : imaj -> görüntü
(define (imaj->görüntü i)
  (cond
    ((anim? i) (anim-çiz i))
    (else i)))

;; imaj-güncelle : imaj ->imaj
;; imajı güncell
(define (imaj-güncelle i)
  (cond
    ((anim? i) (anim-güncelle i))
    (else i)))


; STRUCT nesne
;; imaj : imaj - nesnenin imajı
;; yer : v - nesnenin ekrandaki yeri
;; hız : v - nesnenin hızı
;; ivme : v - nesnenin ivmesi
(STRUCT nesne (imaj yer hız ivme))

;;nesne-güncelle
;;nesne -> nesne
;;bir nesne alıp bir saniye sonraki halini üreterek yeni nesneyi verir.

;;template
;;(define (nesne-güncelle a)
;; (nesne ... (nesne-imaj a) ... (nesne-yer a) ... (nesne-hız a) ... (nesne-ivme a)... ) )
;;

;;örnekler:

(ÖRNEK (nesne-güncelle (nesne (circle 10 "solid" "purple") (v 3 5) (v 2 6) (v 3 5))) (nesne (circle 10 "solid" "purple") (v 5 11) (v 5 11) (v 3 5)))
(ÖRNEK (nesne-güncelle (nesne (star 5 "outline" "black") (v 6 7) (v 0 3) (v 2 1))) (nesne (star 5 "outline" "black") (v 6 10) (v 2 4) (v 2 1)))
(ÖRNEK (nesne-güncelle (nesne (triangle 8 "solid" "blue") (v 7 9) (v 1 5) (v 3 8))) (nesne (triangle 8 "solid" "blue") (v 8 14) (v 4 13) (v 3 8)))
(ÖRNEK (nesne-güncelle (nesne (circle 3 "outline" "yellow") (v 2 2) (v 6 3) (v 5 1))) (nesne (circle 3 "outline" "yellow") (v 8 5) (v 11 4) (v 5 1)))

(define (nesne-güncelle a) 
  (nesne (imaj-güncelle (nesne-imaj a)) (v+ (nesne-yer a) (nesne-hız a)) (v+ (nesne-hız a) (nesne-ivme a)) (nesne-ivme a)))


