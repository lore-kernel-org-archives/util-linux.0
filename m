Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A0C00528
	for <util-linux@archiver.kernel.org>; Mon,  7 Aug 2023 15:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjHGPnk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHGPnk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Aug 2023 11:43:40 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 08:43:29 PDT
Received: from dellerweb.de (unknown [IPv6:2a02:c207:3003:236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940519A2
        for <util-linux@vger.kernel.org>; Mon,  7 Aug 2023 08:43:29 -0700 (PDT)
Received: from mx3210.localdomain (unknown [142.198.148.3])
        by dellerweb.de (Postfix) with ESMTPSA id 7C36A160027F;
        Mon,  7 Aug 2023 17:37:20 +0200 (CEST)
Received: by mx3210.localdomain (Postfix, from userid 1000)
        id D605222012C; Mon,  7 Aug 2023 15:37:17 +0000 (UTC)
Date:   Mon, 7 Aug 2023 15:37:17 +0000
From:   John David Anglin <dave@parisc-linux.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] Fix build on hppa
Message-ID: <ZNEPrah0JvjV24vw@mx3210.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RxVcJPfPNyJXKsOL"
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--RxVcJPfPNyJXKsOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch fixes the definition of SECCOMP_ARCH_NATIVE
on hppa.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
---

--- ./include/audit-arch.h.save	2023-08-03 20:42:00.937401304 +0000
+++ ./include/audit-arch.h	2023-08-03 20:53:40.755627981 +0000
@@ -57,6 +57,12 @@
 #    else
 # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_LOONGARCH64
 #    endif
+#elif __hppa__
+#    if __SIZEOF_POINTER__ == 4
+#	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PARISC
+#    else
+#	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PARISC64
+#    endif
 #else
 #    error Unknown target architecture
 #endif

--RxVcJPfPNyJXKsOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEnRzl+6e9+DTrEhyEXb/Nrl8ZTfEFAmTRD6MACgkQXb/Nrl8Z
TfHpxBAAp5Z90KHtsxP/bKkKMnZd8tc941/Rugk9IUlx8Wl4dEpNc5zOtsdB7Yhb
L8NSzQkYc2spCOzEindEpyO0TATWOmLLnO61+zfy+HhFgDHRR8+P5NSpQfMT+CM0
iEMQ//PpSPvGQfvsT5da6Bwus3PC3l3yOQ1827zoWHUwIups+jQbAxp3G3zRv1kL
BXt8lAkZKCEwYoP/uh9yRDbykDLPZ23WhNFokLcEaErukdH6XLAPqdzmLiBam+ec
zBPLrMxT5j12Mv5j9B4QvZZn5MhhSnE4urZG3ejuI3r2oi2IQfWg2PSTL9Th8Nvz
7RRHGcEXicHab0mYgCFKj3FnWef4XtgFluAdwdtD2SgJ62QFor8Edh9yI3u8jBvE
ow+ZNtegeEodWnCOetsn22F6G4GpOK3qv8F7I/xargvOpkf9FGT9ZsN4NKhAXgOu
eS+xrCt54z99QMSMB4kwdVTPlWydSzE3Z/WAV38puHBTQVCJgltFsdfAXLfexUOQ
Mr9t/VszYgVATms9zW8iz6jYu5d6QjmLwMftRqkoMl/e8pg1TBL9vYjCY7A1vQ4G
mHuNlm4mGBmdEAmVDCCbgNXn7ttYfWprI/K6bi3L3tDjHm61+2XgmPMMSXXnOKnP
sWkjmhrI5MLItf8Emogh5/77RSbB5qW0GTmIA1fM1BJnikVQdec=
=49Uf
-----END PGP SIGNATURE-----

--RxVcJPfPNyJXKsOL--
