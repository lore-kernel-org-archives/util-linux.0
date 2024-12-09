Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD29474
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711256; cv=none; b=UiMxIxPuVrLHS6tZFaJoWeZXa5rSvY4ysrEu9aoMHslKkn+KmI291ap0VYII/8ueb6njqxowif4HWi545CNoevKdSD6OdD9H7nvSjQRjUakBCwE2hq6RikO1dsecG0Vqka9/UcjuUF/GztHEFUOVEE08+TStoaGckj/qyOzz+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711256; c=relaxed/simple;
	bh=ib5gfdJbA9YuFnQ/11xKqgwbf6nSUN6z35Fsg/zcTWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuFiHkwP9NJhYcW25JiTthpcZz0RYJJK9U6YYH+yUkTnMXM/VZu1O85n6GZchVeIFTRPlpY2r5L2TTmIAbSwbuOy9bqoFX4TT/iaUpjG5iVcKfdjf7JVCtOcky7uctcG9dZ4kMKHcgiAkboDQ96cX1MWAaC1R4SiHG831OUaaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KoUX3zh/; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KoUX3zh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=S+5lD
	cDgPtgYt2tJEA8svWkVggs+pfckXLNsXCRWGWc=; b=KoUX3zh/kwxdO0WUwcxXU
	HBANkIaXTSTGsqtx/bXY/DWKTJd1pCy1JI8i/NGg2LdWRBaQr+nxUqXkazb0otfX
	HAfn8IUTPsB5kwPFfUZ9wLrPsX8bzmtBUPr794xbbnwnARi3z4MtSBRbC734ucMo
	KofUDqL9KSFoHfeC4httJ8=
Received: from chenw.lan (unknown [121.12.217.185])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3fw3qUVZn8h13Dw--.56815S2;
	Mon, 09 Dec 2024 10:12:08 +0800 (CST)
From: Zhaoming Luo <zhmingluo@163.com>
To: util-linux@vger.kernel.org
Cc: samuel.thibault@gnu.org
Subject: [RFC PATCH] hwclock: Remove ioperm declare as it causes nested extern declare warning
Date: Mon,  9 Dec 2024 10:11:54 +0800
Message-ID: <20241209021154.255340-1-zhmingluo@163.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fw3qUVZn8h13Dw--.56815S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr13KF1DtF15Wr4UAw18Krg_yoW8JFy7pF
	nrCr4Yy3yjyw10vF92q3s5W3srA345G347AF42qr4jqFy2yrykXFyftF90ka4YqFyfCayq
	v347Gryjyr45AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXAwsUUUUU=
X-CM-SenderInfo: p2kpx0pjox0qqrwthudrp/1tbiERiwLGdWRa6n6QABsA

The extern declaration causes the following warning:

```
  CC       sys-utils/hwclock-hwclock-cmos.o
sys-utils/hwclock-cmos.c: In function 'i386_iopl':
sys-utils/hwclock-cmos.c:356:20: warning: nested extern declaration of 'ioperm' [-Wnested-externs]
  356 |         extern int ioperm(unsigned long from, unsigned long num, int turn_on);
      |                    ^~~~~~
sys-utils/hwclock-cmos.c:356:20: warning: redundant redeclaration of 'ioperm' [-Wredundant-decls]
In file included from sys-utils/hwclock-cmos.c:68:
/usr/include/i386-gnu/sys/io.h:29:12: note: previous declaration of 'ioperm' with type 'int(long unsigned int,  long unsigned int,  int)'
   29 | extern int ioperm (unsigned long int __from, unsigned long int __num,
      |            ^~~~~~
  CCLD     hwclock
```

---
 sys-utils/hwclock-cmos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 7e5eecc7d..c7f82437d 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -352,7 +352,6 @@ static int i386_iopl(const int level)
 # else
 static int i386_iopl(const int level __attribute__ ((__unused__)))
 {
-	extern int ioperm(unsigned long from, unsigned long num, int turn_on);
 	return ioperm(clock_ctl_addr, 2, 1);
 }
 # endif
-- 
2.47.1

