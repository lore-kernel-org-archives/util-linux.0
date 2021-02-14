Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2957EC433E0
	for <util-linux@archiver.kernel.org>; Sun, 14 Feb 2021 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C6F64DA1
	for <util-linux@archiver.kernel.org>; Sun, 14 Feb 2021 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhBNPtD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 14 Feb 2021 10:49:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:46567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNPtC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 14 Feb 2021 10:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613317650;
        bh=9VO40/4A0DBj6ohiXsIciS8lCYxMMfGmMZUSZUup+kE=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=FiJOGQWdjT5BA3/tasTYOoM4xyHlxVH5CaxxiKYuEBJ+jxQF1QqFmFujRWbIds/X0
         VQnukvONt9//p6NFImLG0Q8aC/3G4ZhXT3WphGqhWeqw3hjE6DKI2N9LBGUFso0JP8
         b0Z8t5t2aFeintDXLBXnYkHXWYlDNY/cvdJ9CMKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([62.216.208.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1lP2t12lW6-00VMn8; Sun, 14
 Feb 2021 16:47:29 +0100
Date:   Sun, 14 Feb 2021 16:47:28 +0100
From:   Peter Seiderer <ps.report@gmx.net>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Typo in commit build-sys: release++ (v2.36.2)?
Message-ID: <20210214164728.7f461991@gmx.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pMwnk5hW/7aKa/gDkVsczyaXItB5SuaIcjIEv7OAWzrAz0FT/p3
 /x7eqOhyDxtSgZlZ38yuKMgjf0WijWC91iuHUQucsNNXfhAC1EzOzE3lUWLySlG5UE5i1IR
 VzP+iuGVAoTgFTNKtVlMM9U+k6gUdAxl8dpr34Vifg9A3CSrzRR+8nyHPm0FssdTzJnnIuP
 OiTk5NRxtx6hZVVeArvxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:89FHw6sS+NM=:o38SaIhTttibhfYo/q26FT
 N8J0K2nCrDhn2Y4PMKcN2M49fQJfcbTPARSeX1JeSvBpLP6uYblwcn+edVOKnGz+qaOoGhd6z
 VZ3+cWdzgu14wlCm01Lf/lAFdXITuW+lHL/RkFUJ9ncps9iBIyy7sMg+FzpSQKxLuHiyO80xd
 6bCRbT1r7FMDU+3AZVleyzj2lZqbpo9K+UwAlQRAuxkj8iUQpFsF5hSZGsL9D6Nkc3p1ZFFEW
 a0NmrBFuxzCaAFRXU0rumSh8mYOlLvS4lqQzlOzgRdLkCStkKGaRYgo+U9QconOLgWH9C+RjD
 mGbODEn3NlNQcxqdM5+vCCzTRZwWZNdCsE9XluuynxxjOOP644oktdJBBEYtBcvSrUx5O8Txc
 HxMWRsu9p4oNtwBTWkbuXm97uJf1r4dZn0qgqJayC71rksAiGnuYRRZyktaYZcp+aAxY4qBJi
 iX0gNGkxceFxWqGvCn+kDuiQ4fdW0vnPGgvSjwUOx4uw0iu2PQ1YsZadKlwgQ0pwAIuOvIhXp
 PI8EsbOuSZnvhPK4dZiarcK7uAWseJANJYVpKsXBC5CgKsULFy00g4CWydrCVkFOe31Fzdj+Q
 d0pstAoQ0yWoCxH3g2mUaQ6HyD78VbIEhhJEXFTE8q1Yk7I2BXag6cukwlQYKm2K8riBx+Kww
 fD09i1k3nZNyGW2liOUzqmHIrgt51tq/quXetNe1odPxZay4vr1o/+5o7FKUQWf2yQHIThM+K
 fjLTC+bXTB/v66nM+WawZBghtip7X+z3Bz2KoEJoe/YgGWfD8/HBuKis82gVghZUGLWSGw0wP
 J6xbTh/obg7Vv7fta8dxrgbGI8XHL65DxwenQAiKlnWgdPKQd6R1xcrKAtQj4FgBfxnT7Mglh
 a25nUjsF4MnTD69jAqoA==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

the commit for release v2.36.2 ([1]) 'build-sys: release++ (v2.36.2)'
contains a typo setting LIBBLKID_DATE to '12-Feb-2020'
instead of '12-Feb-2021'?

=2D-- a/configure.ac
+++ b/configure.ac
@@ -29,7 +29,7 @@ PACKAGE_VERSION_RELEASE=3D$(echo $PACKAGE_VERSION | awk =
-F. '{

 dnl libblkid version
 LIBBLKID_VERSION=3D"$PACKAGE_VERSION_MAJOR.$PACKAGE_VERSION_MINOR.$PACKAG=
E_VERSION_RELEASE"
-LIBBLKID_DATE=3D"16-Nov-2020"
+LIBBLKID_DATE=3D"12-Feb-2020"
 LIBBLKID_LT_MAJOR=3D1
 LIBBLKID_LT_MINOR=3D1
 LIBBLKID_LT_MICRO=3D0

Regards,
Peter

[1] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/=
configure.ac?h=3Dstable/v2.36&id=3Db897734b57ea06643fa916f15270f21ea2f1443=
1
