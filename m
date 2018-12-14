Return-Path: <SRS0=7McB=OX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FBC43387
	for <util-linux@archiver.kernel.org>; Fri, 14 Dec 2018 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC29C206DD
	for <util-linux@archiver.kernel.org>; Fri, 14 Dec 2018 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+G/WZSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeLNRyF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:54:05 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:33682 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLNRyE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 14 Dec 2018 12:54:04 -0500
Received: by mail-io1-f54.google.com with SMTP id t24so5124825ioi.0
        for <util-linux@vger.kernel.org>; Fri, 14 Dec 2018 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=krPHk9cuyTmhBjVPv1jCf9Wg39AFThwDbDOs1L3h59M=;
        b=J+G/WZSOiZa9JmpsQFLcq/LFck8ty57H+VKt/qNW/pxVilQeph8KDTcztFaHUdFlMf
         NNJtOKsKL1Gof2n09w1FAqLHzf7FcOoJ44RD/2k3z/kyFk2Gw7tpZOUFcMBTS8+GFZzL
         fBgEsoOs9KTxqwHfWd9EYUU3BN9aJJ7MEJy1AmzEdH3rJBoBTgECG/xcN/0K+Dr8Txxp
         K3N58DPhywRt8ZHMsepl/+23JEmqegz+67ceZ6hJMmeWLTQ3PSlTCXW1HRNnGQji4Ee1
         m8M2yWWajjH84qz73WmEJPfbCKP2CqejkM+o+hZmqHCbCZsJAT0WVzhBryj3ZhZ8BLh4
         UFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=krPHk9cuyTmhBjVPv1jCf9Wg39AFThwDbDOs1L3h59M=;
        b=HM9GfF56ket5g/Pc6QXSm9TMAM0SIZ8Fry6RZBR2Uj8lgfDt09ejgbrhmNNAFTqugx
         KSXElNikDix6yanwv3de5UKcMsNZwjjXK2Cy1AkeipYjelh1Y5EI2XRIzHKu7imS49v8
         ZiQg0zfK1ORON5qaC9sBMeJtyP0K2JxOfQqkjpkBsvbzw5JUF14UY6MGecQlrxSeXsj7
         uGEMOAHmfW79+z2lZmxIo9J5Xxkg97bVL2H4iMc5VvsVLpZwvPunEmxjVIEAeGKq88jm
         DlxH5Lim81K/NJpcA3QGKAstmuuETr9VdAtcX+ojr9Z0okZHxiI9ak/1qXHN/Jb+ILCi
         38Vw==
X-Gm-Message-State: AA+aEWYgyheDjKe766y1xGjkixE3EClDQGkydTwepqoOq//JJUSVKaYG
        lXXOhcP7LY49QqSyDhhKQVUQ4vhuBJ7u2k2R3XgfmatrK1c=
X-Google-Smtp-Source: AFSGD/V9T2qt6bE1YVYDTWO/nTYvGa8M/JeOuDuPagbfYvBdKlKVBXPybd6BG49+2qfzaU9oZMcrRleSbnQ0wsomCFQ=
X-Received: by 2002:a5d:8d85:: with SMTP id b5mr3584530ioj.38.1544810043228;
 Fri, 14 Dec 2018 09:54:03 -0800 (PST)
MIME-Version: 1.0
From:   Hank Barta <hbarta@gmail.com>
Date:   Fri, 14 Dec 2018 11:53:52 -0600
Message-ID: <CABTDG89z-g=LmHobptPBmYVzTucz_ZWrPo4yo_Gh7O9ZEQAqfQ@mail.gmail.com>
Subject: Partitioning or blkid issue?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I have an issue where `gparted` seems to display incorrect information
on my system drive (and `parted` seems to report correct information.)
I filed a bug on Launchpad (since this manifests on Ubuntu 18.10)
https://bugs.launchpad.net/ubuntu/+source/gparted/+bug/1808421 and was
directed to https://gitlab.gnome.org/GNOME/gparted/issues/14 which
does appear to be the same issue. Near the end of the first link is
information I collected when running Ubuntu 18.04 (from `blkid` and
`wipefs`)

I have found that when this system is running Debian Stretch from USB
that `gparted` appears to produce the correct output. Below is the
same information collected when running Debian Stretch.

root@debian:/home/user# apt policy util-linux
util-linux:
  Installed: 2.29.2-1+deb9u1
  Candidate: 2.29.2-1+deb9u1
  Version table:
 *** 2.29.2-1+deb9u1 500
        500 http://deb.debian.org/debian stretch/main amd64 Packages
        100 /var/lib/dpkg/status
root@debian:/home/user# blkid /dev/sda
/dev/sda: LABEL="rpool" UUID="4510611204828545482"
UUID_SUB="9816084798696086204" TYPE="zfs_member"
PTUUID="eba09d2e-0f70-4d11-8e37-c1c170cfd9dd" PTTYPE="gpt"
root@debian:/home/user# wipefs --no-act /dev/sda
offset               type
----------------------------------------------------------------
0x200                gpt   [partition table]

0xe8e0d3f000         zfs_member   [filesystem]
                     LABEL: rpool
                     UUID:  4510611204828545482

root@debian:/home/user#

I would like to know if this identifies a problem in the partition
table or an issue with `blkid`. (Or something else?)
I don't think I installed a ZFS pool on the entire disk but I could be
wrong about that. It is also possible that one of my operations did
cause a problem with the partition table.
This is a test system and relatively new install so it would not be a
huge problem to 'nuke and repave' if that is necessary to fix this or
to try anything that can further identify the problem.

Suggestions on what I should do next are most welcome!

Thanks!

-- 
Beautiful Sunny Winfield, Illinois
