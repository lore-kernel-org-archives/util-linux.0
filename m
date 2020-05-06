Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB90C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235172076D
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEFTGi convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 15:06:38 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33504 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEFTGi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 15:06:38 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6D72C56491B
        for <util-linux@vger.kernel.org>; Wed,  6 May 2020 21:06:32 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id j21so1537183pgb.7
        for <util-linux@vger.kernel.org>; Wed, 06 May 2020 12:06:32 -0700 (PDT)
X-Gm-Message-State: AGi0PuZUhCGQwHCK/X+ZJIWoA/rPmyxaFrN+/w0QYauJyL0ENJpmGalo
        /RDrFdF0PmuZLkSq7R7nHYXEL58CD8/3ohw13SQ=
X-Google-Smtp-Source: APiQypJaAwJo/KJZuVVrBpkwjsc9S46Vggluy9wjglmnxvSPgT5WtWoCLrRgmxNksPAQIhc4O1GOrkLd44WjobVzCH8=
X-Received: by 2002:a63:5445:: with SMTP id e5mr8095683pgm.185.1588791990441;
 Wed, 06 May 2020 12:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
 <20200414113827.xp2etrdev2oom4qc@ws.net.home> <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
 <20200506133555.wbrul6yy24ycpfk3@ws.net.home>
In-Reply-To: <20200506133555.wbrul6yy24ycpfk3@ws.net.home>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Wed, 6 May 2020 21:06:19 +0200
X-Gmail-Original-Message-ID: <CAA0A08UeXO5m8-Q0PS=kQH=MmG6q4EnjJw84JN=ckTuj4Qrnhg@mail.gmail.com>
Message-ID: <CAA0A08UeXO5m8-Q0PS=kQH=MmG6q4EnjJw84JN=ckTuj4Qrnhg@mail.gmail.com>
Subject: Re: cal: column mode
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed May  6 21:06:32 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

>
> > > On Mon, Apr 13, 2020 at 10:41:34PM +0200, Aurélien Lajoie wrote:
> > > > As I have announced few days ago, I have started to work on ncal like for cal.
> > > > I have push a first working version on my github:
> > > > https://github.com/utix/util-linux/commits/cal_column
>
> Aurélien, what is the current status of this your patch? I'd like to
> make v2.36 release at the of the May :-)
>
>

Hi,

it is finished, doing several test.
I have tested with mn_MN.utf8, fr_FR.utf8 and english.
I have some test to be committed.
I will push all for the end of the week.

My version
     May 2020
Su      3 10 17 24 31
Mo      4 11 18 25
Tu      5 12 19 26
We      6 13 20 27
Th      7 14 21 28
Fr   1  8 15 22 29
Sa   2  9 16 23 30


     Тавдугаар сар             Зургадугаар сар           Долдугаар сар
      2020                      2020                      2020
Да       125 132 139 146       153 160 167 174 181           188 195 202 209
Мя       126 133 140 147       154 161 168 175 182           189 196 203 210
Лх       127 134 141 148       155 162 169 176           183 190 197 204 211
Пү       128 135 142 149       156 163 170 177           184 191 198 205 212
Ба   122 129 136 143 150       157 164 171 178           185 192 199 206 213
Бя   123 130 137 144 151       158 165 172 179           186 193 200 207
Ня   124 131 138 145 152       159 166 173 180           187 194 201 208
      18  19  20  21  22        23  24  25  26  27        27  28  29  30  31

      Наймдугаар сар            Есдүгээр сар              Аравдугаар
сар
      2020                      2020                      2020
Да       216 223 230 237 244       251 258 265 272           279 286 293 300
Мя       217 224 231 238       245 252 259 266 273           280 287 294 301
Лх       218 225 232 239       246 253 260 267 274           281 288 295 302
Пү       219 226 233 240       247 254 261 268           275 282 289 296 303
Ба       220 227 234 241       248 255 262 269           276 283 290 297 304
Бя   214 221 228 235 242       249 256 263 270           277 284 291 298 305
Ня   215 222 229 236 243       250 257 264 271           278 285 292 299
      31  32  33  34  35  36    36  37  38  39  40        40  41  42  43  44

      Арван нэгдүгээр сар       Арван хоёрдугаар сар      Нэгдүгээр
сар
      2020                      2020                      2021
Да       307 314 321 328 335       342 349 356 363             4  11  18  25
Мя       308 315 322 329       336 343 350 357 364             5  12  19  26
Лх       309 316 323 330       337 344 351 358 365             6  13  20  27
Пү       310 317 324 331       338 345 352 359 366             7  14  21  28
Ба       311 318 325 332       339 346 353 360             1   8  15  22  29
Бя       312 319 326 333       340 347 354 361             2   9  16  23  30
Ня   306 313 320 327 334       341 348 355 362             3  10  17  24  31
      44  45  46  47  48  49    49  50  51  52  53        53   1   2   3   4

      Хоёрдугаар сар            Гуравдугаар сар           Дөрөвдүгээр
сар
      2021                      2021                      2021
Да    32  39  46  53            60  67  74  81  88            95 102 109 116
Мя    33  40  47  54            61  68  75  82  89            96 103 110 117
Лх    34  41  48  55            62  69  76  83  90            97 104 111 118
Пү    35  42  49  56            63  70  77  84            91  98 105 112 119
Ба    36  43  50  57            64  71  78  85            92  99 106 113 120
Бя    37  44  51  58            65  72  79  86            93 100 107 114
Ня    38  45  52  59            66  73  80  87            94 101 108 115
       5   6   7   8             9  10  11  12  13        13  14  15  16  17


ncal
    Тавдугаар сар 2020      Зургадугаар сар 2020    Долдугаар сар 2020
Да     125 132 139 146     153 160 167 174 181         188 195 202 209
Мя     126 133 140 147     154 161 168 175 182         189 196 203 210
Лх     127 134 141 148     155 162 169 176         183 190 197 204 211
Пү     128 135 142 149     156 163 170 177         184 191 198 205 212
Ба 122 129 136 143 150     157 164 171 178         185 192 199 206 213
Бя 123 130 137 144 151     158 165 172 179         186 193 200 207
Ня 124 131 138 145 152     159 166 173 180         187 194 201 208
    17  18  19  20  21      22  23  24  25  26      26  27  28  29  30

    Наймдугаар сар 2020     Есдүгээр сар 2020       Аравдугаар сар 2020
Да     216 223 230 237 244     251 258 265 272         279 286 293 300
Мя     217 224 231 238     245 252 259 266 273         280 287 294 301
Лх     218 225 232 239     246 253 260 267 274         281 288 295 302
Пү     219 226 233 240     247 254 261 268         275 282 289 296 303
Ба     220 227 234 241     248 255 262 269         276 283 290 297 304
Бя 214 221 228 235 242     249 256 263 270         277 284 291 298 305
Ня 215 222 229 236 243     250 257 264 271         278 285 292 299
    30  31  32  33  34  35  35  36  37  38  39      39  40  41  42  43

    Арван нэгдүгээр сар 2020Арван хоёрдугаар сар 2020Нэгдүгээр сар 2021
Да     307 314 321 328 335     342 349 356 363           4  11  18  25
Мя     308 315 322 329     336 343 350 357 364           5  12  19  26
Лх     309 316 323 330     337 344 351 358 365           6  13  20  27
Пү     310 317 324 331     338 345 352 359 366           7  14  21  28
Ба     311 318 325 332     339 346 353 360           1   8  15  22  29
Бя     312 319 326 333     340 347 354 361           2   9  16  23  30
Ня 306 313 320 327 334     341 348 355 362           3  10  17  24  31
    43  44  45  46  47  48  48  49  50  51  52      52   1   2   3   4

    Хоёрдугаар сар 2021     Гуравдугаар сар 2021    Дөрөвдүгээр сар 2021
Да  32  39  46  53          60  67  74  81  88          95 102 109 116
Мя  33  40  47  54          61  68  75  82  89          96 103 110 117
Лх  34  41  48  55          62  69  76  83  90          97 104 111 118
Пү  35  42  49  56          63  70  77  84          91  98 105 112 119
Ба  36  43  50  57          64  71  78  85          92  99 106 113 120
Бя  37  44  51  58          65  72  79  86          93 100 107 114
Ня  38  45  52  59          66  73  80  87          94 101 108 115
     5   6   7   8           9  10  11  12  13      13  14  15  16  17


>
>   Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

