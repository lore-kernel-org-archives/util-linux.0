Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A256B9F
	for <util-linux@vger.kernel.org>; Mon, 15 Apr 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176660; cv=none; b=lDgI50F7nD+C4ZjdJFPExk+Udhs8BEKPCTm9xTk0iKao2NRMMGoG24mMfMmujkbogV3lQc1WLgp4MbjInmC9g22YBqenJ4k21qPxwoyysCnPV3MpObj1csC1UanMIJzGz2xi7GajVU9LCt+y/EdzZRMjCal/bgF3RZigvHgktHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176660; c=relaxed/simple;
	bh=QA3Cbcka4HrM6EPEgCIkUPNk8Kz3J8lWD0BeYeU//IY=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=IqSvG8qqlt5y/uuOg7rQjlA+Nm2uXTAe5X11meYgYqS/gBedPi7s1zvNsytWX0FsrlAn3QSyZNDY/yscZQtB/qm6pQ8kMqgThNi469fFn6Nd79MGujMkL9bI9v4U8RRV4BweSMOflF8b+ccOWYb6kEb2i0FJgF1SQYWq75l0s/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Y0oOUNR8; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Y0oOUNR8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jN0siaFN0FhGnw9E9p64E8bWKBZ5e7XD1D9HjJ670V8=; t=1713176656; x=1713781456; 
	b=Y0oOUNR84BcfDtKTdzWdGN3gIVOsMyoeiL8ZLO9AmeUFmaDEvhxgGSY/asqDD1PFyMZr59YUYXU
	46j+kG+66iBlI1gLzVWiTzXpDQx4UzBQK9my+gHvlMghG2o8mRHYolLoyx3gpUEaZjXSJ7oMTqqL4
	VeLkN2zvVy9kYn+MnlD4wvd6Sx1Z/p++CR5vVJdgGT/ADuzyX6nlBlqkXaGS5HGwyiz5vSaJhdpMa
	VMC8itchWA5eBEYuggKj9DQ41zMPeGMj6312k5VmQVfIFjEKqOejzxEwS9ugVAVhFIOeeEeY12CXZ
	jB2KtNsiL1Mm3pKxlvNct+RzB6hBxpOakJNg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          for util-linux@vger.kernel.org with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rwJVQ-00000002p7N-3dVj; Mon, 15 Apr 2024 12:24:08 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          for util-linux@vger.kernel.org with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rwJVQ-00000002JcL-2oDk; Mon, 15 Apr 2024 12:24:08 +0200
Message-ID: <31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de>
Subject: lsfd/error-eperm test fails on git master
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: util-linux <util-linux@vger.kernel.org>
Date: Mon, 15 Apr 2024 12:24:08 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

lsfd/error-eperm fails for me on git master. I have reproduced the issue
on 32-bit PowerPC, 64-bit SPARC, 64-bit s390x and x86_64.

Is there a tentative fix for this failure?

Thanks,
Adrian

(sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$ ./run.sh lsfd=
/error-eperm

-------------------- util-linux regression tests --------------------

                    For development purpose only.
                 Don't execute on production system!

       kernel: 6.6.15-powerpc64

      options: --srcdir=3D/home/glaubitz/util-linux-git/tests/.. \
               --builddir=3D/home/glaubitz/util-linux-git/tests/..

         lsfd: fd opening a file cannot be stat(2)'ed ... FAILED (lsfd/erro=
r-eperm)

---------------------------------------------------------------------
  1 tests of 1 FAILED

      lsfd/error-eperm
---------------------------------------------------------------------
(sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$

diff-{{{
--- /home/glaubitz/util-linux-git/tests/expected/lsfd/error-eperm       202=
4-04-09 09:22:29.505017516 +0000
+++ /home/glaubitz/util-linux-git/tests/output/lsfd/error-eperm 2024-04-15 =
08:37:38.326220593 +0000
@@ -1,2 +1,2 @@
-mem ERROR stat:EPERM
+mem ERROR stat:unknown(1)
 ASSOC,TYPE,SOURCE:  0
}}}-diff

 libsmartcols: fromfile: [15] wrap-tree                      ... OK
         lsfd: fd opening a file cannot be stat(2)'ed        ... FAILED (ls=
fd/error-eperm)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
