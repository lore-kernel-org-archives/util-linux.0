Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581D1FA8D2;
	Fri,  3 Jan 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912957; cv=none; b=HoA0r/uAl/RXp0XGKO4+A1qIBYYr2U7vKMhGMhLpprRMF3Ywtx1oLYys/URlQzkI74A8GHJD9LcG4P14TVMdHElkY3g8sOUZcR8ee8U7CfxWBLi4++CVsdd0bCxU3WWphwoHW4Hne4elKxmbX2pE93qAGWk7F71s/SE3a4UAg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912957; c=relaxed/simple;
	bh=RcFRE1wCQwZTbVVMt/Q7RQndy+HdeYB/CgEaSruEwBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nomf/xo/D3XnXiE6GV5lJ/mmJRaH13XdDfKbqAI9QTpWM74JU1RT/CaHf33TCIQ/tLGqJBTuAT7Fn+ur8c0scId90ZXmv4zcBsD5mRNek/TOnHvHuGMq89/hpRmuO8sVUST0W8rs9yxcyVXDdu4VUfUp8SRGq2eGORzytEKSqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fcyzG6BL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fcyzG6BL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I8WoaN64gHSpe9wGDSBv1yuM3/6je8qwnfXSNYl8V4Y=; t=1735912950; x=1736517750; 
	b=fcyzG6BLK8eJ2XTS0YCrXWcYUAXgyPIb8pWqZYhV93Yi90mFa7wbuL1GHsj1DJQP0wgvraz3tO+
	muMNbiwXY/1yJ1oiwRZyPVLIsBp1kLOrKf/NDSkG0GSW4uP5MUAFsi/kxm30bufsrvMVpgOoKw7Yc
	DkevO6Bp5CPfnXte0Tq7LHLBSJAT1QbBFMhCjosDw07pv269GQVIBEqfhQE0gRtDhUeFE3vmn17BL
	Z3B4MtDylYzdD3bmJTlNS4Pf6RN2UZWFO8Sz+cHZLVBnlUvOjxFGME5z8VbG/H1Jwm/0Xwh5txXHv
	eIJINX0f2ynWoKQpDh3smHbhdBB8G3X2o19g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tTiFX-00000000P7D-23jf; Fri, 03 Jan 2025 15:02:03 +0100
Received: from p57bd9274.dip0.t-ipconnect.de ([87.189.146.116] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tTiFX-00000002btC-0ulp; Fri, 03 Jan 2025 15:02:03 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1tTiFW-001YM0-2E;
	Fri, 03 Jan 2025 15:02:02 +0100
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Michael Cree <mcree@orcon.net.nz>,
	Sam James <sam@gentoo.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Chris Hofstaedtler <zeha@debian.org>,
	util-linux@vger.kernel.org
Subject: [PATCH] alpha: Fix personality flag propagation across an exec
Date: Fri,  3 Jan 2025 15:01:46 +0100
Message-Id: <20250103140148.370368-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

It was observed that on alpha, the misc/setarch test of
the util-linux testsuite failed with the following error:

   misc: setarch                        ...
          : options                     ... OK
          : uname26                     ... OK
          : uname26-version             ... FAILED (misc/setarch-uname26-version)
          : show                        ... OK
     ... FAILED (1 from 4 sub-tests)

Running the setarch binary manually confirmed that setting
the kernel version with the help --uname-2.6 flag does not
work and the version remains unchanged.

It turned out that on alpha, the personality flags are not
propagated but overridden during an exec. The same issue was
previously fixed on arm in commit 5e143436d044 ("ARM: 6878/1:
fix personality flag propagation across an exec") and on powerpc
in commit a91a03ee31a5 ("powerpc: Keep 3 high personality bytes
across exec"). This patch fixes the issue on alpha.

With the patch applied, the misc/setarch test succeeds on
alpha as expected:

   misc: setarch                        ...
          : options                     ... OK
          : uname26                     ... OK
          : uname26-version             ... OK
          : show                        ... OK
     ... OK (all 4 sub-tests PASSED)

However, as a side-effect, a warning is printed on the kernel
message buffer which might indicate another unreleated bug:

[   39.964823] pid=509, couldn't seal address 0, ret=-12.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/alpha/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
index 4d7c46f50382..81f8473bb7c0 100644
--- a/arch/alpha/include/asm/elf.h
+++ b/arch/alpha/include/asm/elf.h
@@ -138,8 +138,8 @@ extern int dump_elf_task(elf_greg_t *dest, struct task_struct *task);
 })
 
 #define SET_PERSONALITY(EX)					\
-	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
-	   ? PER_LINUX_32BIT : PER_LINUX)
+	set_personality((((EX).e_flags & EF_ALPHA_32BIT)	\
+	   ? PER_LINUX_32BIT : PER_LINUX) | (current->personality & (~PER_MASK)))
 
 extern int alpha_l1i_cacheshape;
 extern int alpha_l1d_cacheshape;
-- 
2.39.5

