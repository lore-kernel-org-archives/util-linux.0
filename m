Return-Path: <SRS0=OduY=UT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_FUZZY_SECTOR,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B09C43613
	for <util-linux@archiver.kernel.org>; Thu, 20 Jun 2019 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98FE206BA
	for <util-linux@archiver.kernel.org>; Thu, 20 Jun 2019 21:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfFTVmo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:42:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfFTVmo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Jun 2019 17:42:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 321CDAE67
        for <util-linux@vger.kernel.org>; Thu, 20 Jun 2019 21:42:41 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/2] Fix translations for losetup typo fix
Openpgp: preference=signencrypt
Autocrypt: addr=sbrabec@suse.cz; prefer-encrypt=mutual; keydata=
 mQGiBD6v2X0RBAD3rKn9S5s4iKX9KwKPIE1GCEG0qE1UomcIxYhey5oKEVoQoHtJkKvZpOVH
 zXNoPIMdwegZI++89UqY1jz6gI1pyBYRs4qmdnltXToO7NXdCr+LC5XNCStewoCE46gJIsb+
 8DpgK+wPoK/k1bF4HbnImTmkWaRLZKjaFsU4dR3+zwCgxqZXdZMiAYA+1mIjiGRZubOctQUE
 AIZ51+tT+FPkpR8ld+qjHNh1F42y0nCj4dL1oHjWpcq2tzuK+BHzpePsM4rM9ZeYqDSsZIFC
 5ol61NYmKaKDMRjwY5KK+tABm/ha+OCl4twcxtHCoLOcK1N/8/kqZ75x3/NLJwL/BRwaoE0Y
 NsD+BxCW0Rjbiztg2KwkdDWFcCVmBADc/Ka7mKdimHzY6XJ3gIHgFS9fa2rcxKaleajH+dXh
 SPRW8Qil2n/FaAdUIBWL/woF78BAgDfaOGt7Ize+pRVia0e6KD9aUBjRz3ZXmvG17xv83UmW
 ZRP0fpVqA28ou+NvjRNKJtd144OUeMLyEhy82YlkGPwn7r6WhaWo6UIpSLQsU3RhbmlzbGF2
 IEJyYWJlYyAoU3VTRSBDUikgPHNicmFiZWNAc3VzZS5jej6IXwQTEQIAHwQLBwMCAxUCAwMW
 AgECHgECF4AFAlHS/kkFCSE/csAACgkQcXwgn6BPzXZY/gCghbxE4uexFHVP7qho9TDNxGGR
 xxgAoKCipPrJQrnXKhFG4RDeRcVE0PoBuQENBD6v2YIQBACt62O2lXle2CPxw2LpdT557Rvr
 UdoYJ1AeLAn1iDy67rDsGumxJxW254x9CKVsU3609PG58gDKSQ7CvHzErtOdz9xsJLfCCxbk
 6LsOhBdCWgYs7HV2xYCkUvKSVQGZN95skfv1aSsO6dXzXISXen4KqY5AnFa+pXDAqMJTGLwp
 GwADBgQAkZ2/zz99L224sNcFgM+6TuGIQ57fNhKJxYG2HbBqh3oBiiZI9224dKLNCv/2aoV8
 qd9QUMKQCO7kQKkSH7+Ti1KnCyaDi3SoeFcsV4Z99Xb1bN2EBS1C4qohNUbouTsYEG5qsZPe
 uRDKekFTiilRRVyiXWDt+zY2aNNMknKBACeIRgQYEQIABgUCPq/ZggAKCRBxfCCfoE/Ndi+t
 AJ958OvQedgG0gsRG1wX/HKXmRZ0dwCfUk0F4qeP5dCiETIHh3gxNIsx8YQ=
Organization: SUSE Linux, s. r. o.
Message-ID: <8984d835-fd6b-108b-c52e-23a496e2f184@suse.cz>
Date:   Thu, 20 Jun 2019 23:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 po/cs.po    | 2 +-
 po/da.po    | 2 +-
 po/de.po    | 4 ++--
 po/es.po    | 2 +-
 po/fr.po    | 2 +-
 po/hr.po    | 4 ++--
 po/pl.po    | 2 +-
 po/pt_BR.po | 4 ++--
 po/sv.po    | 2 +-
 po/uk.po    | 4 ++--
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/po/cs.po b/po/cs.po
index 35f6f97c9..9c5f0059c 100644
--- a/po/cs.po
+++ b/po/cs.po
@@ -14802,7 +14802,7 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <počet>       omezí zařízení na <počet> bajtů souboru\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
 msgstr " -b, --sector-size <číslo>     nastaví velikost logického sektoru na <číslo>\n"
 
 #: sys-utils/losetup.c:423
diff --git a/po/da.po b/po/da.po
index baf6b4577..24c6ec5ed 100644
--- a/po/da.po
+++ b/po/da.po
@@ -14702,7 +14702,7 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <num>         enhed er begrænset til <num> byte af filen\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
 msgstr " -b, --sector-size <num>       angiv den logiske sektorstørrelse til <num>\n"
 
 #: sys-utils/losetup.c:423
diff --git a/po/de.po b/po/de.po
index c135ce828..ef24a1da4 100644
--- a/po/de.po
+++ b/po/de.po
@@ -14835,8 +14835,8 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <Zahl>       das Gerät ist auf <Zahl> Bytes der Datei beschränkt\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
-msgstr " -b  --sector-size <Zahl>      die logische Sekttorgröße auf <Zahl> setzen\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
+msgstr " -b, --sector-size <Zahl>      die logische Sekttorgröße auf <Zahl> setzen\n"
 
 #: sys-utils/losetup.c:423
 msgid " -P, --partscan                create a partitioned loop device\n"
diff --git a/po/es.po b/po/es.po
index 05e565bbb..7f1e115c0 100644
--- a/po/es.po
+++ b/po/es.po
@@ -14577,7 +14577,7 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <núm>         el dispositivo está limitado a <núm> bytes del fichero\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
 msgstr " -b, --sector-size <núm>       establece el tamaño de sector lógico en <núm>\n"
 
 #: sys-utils/losetup.c:423
diff --git a/po/fr.po b/po/fr.po
index b9fc060b8..f6b696d87 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -14630,7 +14630,7 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <nombre>      périphérique limité à <nombre> octets du fichier\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
 msgstr " -b, --sector-size <taille>    définir la taille de secteur logique à <taille>\n"
 
 #: sys-utils/losetup.c:423
diff --git a/po/hr.po b/po/hr.po
index 74ad956be..3e1db42b6 100644
--- a/po/hr.po
+++ b/po/hr.po
@@ -14752,8 +14752,8 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <broj>        koristi samo taj broj bajtova datoteke\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
-msgstr " -b  --sector-size <broj>      veličinu logičkog sektora postavi na taj broj\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
+msgstr " -b, --sector-size <broj>      veličinu logičkog sektora postavi na taj broj\n"
 
 #: sys-utils/losetup.c:423
 msgid " -P, --partscan                create a partitioned loop device\n"
diff --git a/po/pl.po b/po/pl.po
index 11c53922b..2b8f631b5 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -14576,7 +14576,7 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <ile>         ograniczenie do podanej liczby bajtów pliku\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
 msgstr " -b, --sector-size <ile>       ustawienie rozmiaru sektora logicznego\n"
 
 #: sys-utils/losetup.c:423
diff --git a/po/pt_BR.po b/po/pt_BR.po
index 17120cbc3..503cd8c2a 100644
--- a/po/pt_BR.po
+++ b/po/pt_BR.po
@@ -14721,8 +14721,8 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <núm>         dispositivo limitado a <núm> bytes do arquivo\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
-msgstr " -b  --sector-size <núm>       define o tamanho de setor lógico para <núm>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
+msgstr " -b, --sector-size <núm>       define o tamanho de setor lógico para <núm>\n"
 
 #: sys-utils/losetup.c:423
 msgid " -P, --partscan                create a partitioned loop device\n"
diff --git a/po/sv.po b/po/sv.po
index b7de28cdc..31c8c06cc 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -14550,7 +14550,7 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <num>         enhet är begränsad till <num> byte i filen\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
 msgstr " -b, --sector-size <storlek>   ställ in logisk sektorstorlek\n"
 
 #: sys-utils/losetup.c:423
diff --git a/po/uk.po b/po/uk.po
index b13910ba9..c814a5f44 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -14591,8 +14591,8 @@ msgid "     --sizelimit <num>         device is limited to <num> bytes of the fi
 msgstr "     --sizelimit <n>           пристрій обмежено <n> байтами файла\n"
 
 #: sys-utils/losetup.c:422
-msgid " -b  --sector-size <num>       set the logical sector size to <num>\n"
-msgstr " -b  --sector-size <число>     встановити для логічного сектора розмір <число>\n"
+msgid " -b, --sector-size <num>       set the logical sector size to <num>\n"
+msgstr " -b, --sector-size <число>     встановити для логічного сектора розмір <число>\n"
 
 #: sys-utils/losetup.c:423
 msgid " -P, --partscan                create a partitioned loop device\n"
-- 
2.21.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
