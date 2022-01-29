Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F2C433EF
	for <util-linux@archiver.kernel.org>; Sat, 29 Jan 2022 11:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiA2L5Y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 29 Jan 2022 06:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbiA2L5X (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 29 Jan 2022 06:57:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7340C061714
        for <util-linux@vger.kernel.org>; Sat, 29 Jan 2022 03:57:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so13472721pju.2
        for <util-linux@vger.kernel.org>; Sat, 29 Jan 2022 03:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UsZ2dQV8eoJSG/OawyiWlhJ8B7t74qdjSqH4wD3GIog=;
        b=hum7BajegUTY5iFaQ02gxH0Xr1BjGpNKdjHeneEzEXfWLjr2P2mv3pu9Tcgl8xLVJr
         Dv2SBg/IEF+T6LAKiUKyxRaA8wuKTz8dp4BxPyoR02Skuaffs8DaSOOEcLqSCRXJNLTt
         AQjGJOshMt1kqky6KR+mBcvX7LRk52bTJjL4WCNYODNlBBjdySC3b+oy/5zdyU2yzzv0
         wT0+3Hgf2PNNEhNMOCZmkzLn6y0J774SccB15CTfSEpmeEMTu1LzqH9hvOMJ2ay4vZKg
         eOAl5Ax+yqB276sbui/SChjHWFvC81ZFeUcesfXPHw3Ei1Yn1JAkqU7TSNusiif5QHQF
         da6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UsZ2dQV8eoJSG/OawyiWlhJ8B7t74qdjSqH4wD3GIog=;
        b=StKRVCwY8PpWCW2syiHB+APygJEwoFSMf6ThLJL6v7rmliINwRH9L+iPCGOaDg47sb
         5DZZcKzNPQE6aggYcD/drfvYYS7wW6GGg4jM+z0qtp4/BSe3PRpvb1qSuTYOWYSRiEV0
         1xHlQ9eFcBs+NakUvqYNndPwUNXTBICLNmisjPDksV+HNrgKVjmJODiJwq9OOxN68vLe
         Co/MWLHoczVrrxRScpAUe6MEOqcg05bL4+/Zd5WT/QqI/ULxQtGPcgdfbU2849fPaPf2
         w/GVS60H2j204UAyK566ZtGwss8ZiKoV0IMdK3tZrTX48b2fWHkMNw5cUlo0A4tltN49
         U6kA==
X-Gm-Message-State: AOAM530LrSVxrO87gCj386bkbaG54nfUxe15AyZfTdQ83ckyyXDOzSc9
        eD2OHuQdCQPs7FKnzb2gMEkVDG3v4E2xcwHB7QgghmOXj1E=
X-Google-Smtp-Source: ABdhPJw+U8RE6u2nZoJXFaRVbYOcPNShaTp9LV/MCHs+8PA9hr5ESSoU4nl5qwb9g0RvvWDHJO4vmcS/9Bio1vOY5ww=
X-Received: by 2002:a17:90b:4f4e:: with SMTP id pj14mr14850874pjb.220.1643457443121;
 Sat, 29 Jan 2022 03:57:23 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Sat, 29 Jan 2022 12:57:12 +0100
Message-ID: <CAHi0vA9rJS=+KT2PxTQ9bBeutt9KqpmgvmhJq3VASrKke_h+NQ@mail.gmail.com>
Subject: Unify the --help and --version descriptions in man pages?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

I've just noticed the commit =C2=BBdocs: add man-common/in-bytes.adoc=C2=AB=
.
What about to unify the descriptions of the --help and the --version
options in the man pages in a similar manner? Besides to simplify the
ma=C3=ADntenance, it would also shrink the .po file of the man pages a bit.

Example:

--- blockdev.8.adoc     2021-11-26 17:40:06.931013901 +0100
+++ blockdev.8.adoc    2022-01-29 12:47:43.087144014 +0100
@@ -40,10 +40,10 @@
Print a report for the specified device. It is possible to give multiple de=
vice
s. If none is given, all devices which appear in _/proc/partitions_ are sho=
wn. N
ote that the partition StartSec is in 512-byte sectors.

*-h*, *--help*::
-Display help text and exit.
+include::man-common/help-description.adoc[]

*-V*, *--version*::
-Print version and exit.
+include::man-common/version-description.adoc[]

=3D=3D COMMANDS


=E2=80=A6 and then I would add the files man-common/help-description.adoc a=
nd
man-common/version-description.adoc.

BTW, are there any plans for the next release 2.38? I'm planning to
add direct support for Fedora 36 in manpages-l10n (once it is
available from the servers), in addition to Rawhide. If v2.38 will
come with Fedora 36, I could adjust the package lists appropriately,
to avoid file conflicts.

Best Regards,
Mario
