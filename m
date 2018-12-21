Return-Path: <SRS0=8g6v=O6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B9C43387
	for <util-linux@archiver.kernel.org>; Fri, 21 Dec 2018 04:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B2E21903
	for <util-linux@archiver.kernel.org>; Fri, 21 Dec 2018 04:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5oLbWXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbeLUE0X (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:26:23 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:51707 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbeLUE0X (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Dec 2018 23:26:23 -0500
Received: by mail-it1-f181.google.com with SMTP id w18so5237052ite.1
        for <util-linux@vger.kernel.org>; Thu, 20 Dec 2018 20:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=su4UQougJjoRA60dCXkxymCNHCo6IPIaqJTJFNtwXEQ=;
        b=f5oLbWXnRJYZHCcFN40fSzqWGXK7d41GA8yzH/Md457wAwwqVteQCH8lGr20LOeKE0
         HkvdRc0y3WieBgrtpbLhjtd/tfdnW4m7/e6m/SKWAY8VT9dVdRQfAm/s222IzITeEPw8
         MB4VEr1jQvfcA7Wj+jlbfsNi++gp3W4pQtcQp8PF7GkKgLabOwnUKcQkpTtMczOT6LhM
         mn4b/5v76hx50+ubufrVg7fzZ/zjdWCXuQHszrPHHJkP/Y8aDwlZHnK4yxGpfo8epZEA
         LE+VlJ5QttLDuTC/REAsJFTpStXogXaBkU74IOT6LSJkOwmpt2sYZMfbZ7bestx87wyx
         qacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=su4UQougJjoRA60dCXkxymCNHCo6IPIaqJTJFNtwXEQ=;
        b=RvOtlHkATm24Lp4N4qIigMvEdIGLV5N9kkmk8ijdFZNBNX8K8L1UP6pkTPBeZIhDCH
         8aI8wOwjUa7VTmaYgDLgI4ClrM/S2AZAWl/De1mrdb8i3gK7UAcBvwOE5JLNgfXVNCuQ
         7fJVLtiV09pFWeXmSHWmWiKSNAxDqN6zmpxwmDfSYRJVZQs3HXSNo5b2n42OFLpCqfPX
         RrpKFDA9BF1OgKqxLJ6QHFhkJzIQODYyrNNFZMhEVE0TRPkr/rQ6WIwciPYjFeTpVStZ
         Nf5Sj38hE/2FelD1qmDjnkTU4VHlpaHgGsW74rH+cM6mVXBCyKHagRGHlLg9WudEv3Pu
         pDqQ==
X-Gm-Message-State: AA+aEWbblFTndmKqWts/r3Z06hNsAxXjojVgdlJp61np1kpw6TOCex2N
        tswfykboxwpixApxQ6gGEP4DYgAlSZmRLj7yioh+9A8+
X-Google-Smtp-Source: AFSGD/UK1sS4bdN77XRqymDc10ZXqXqBUSbGBTaDiXiVlU8f6DfN8ZWN0/3g3uBTjhCpeWPHjZvz8KO2NwWpmr0std4=
X-Received: by 2002:a24:1495:: with SMTP id 143mr989643itg.13.1545366380961;
 Thu, 20 Dec 2018 20:26:20 -0800 (PST)
MIME-Version: 1.0
References: <CABTDG89z-g=LmHobptPBmYVzTucz_ZWrPo4yo_Gh7O9ZEQAqfQ@mail.gmail.com>
 <20181217091421.zcj3f3bfe3ps6mpu@ws.net.home>
In-Reply-To: <20181217091421.zcj3f3bfe3ps6mpu@ws.net.home>
From:   Hank Barta <hbarta@gmail.com>
Date:   Thu, 20 Dec 2018 22:26:10 -0600
Message-ID: <CABTDG889Zmk-TOnj9YzGn0ffiU3Nu3FB0gC=yYcYVyB4pMORjw@mail.gmail.com>
Subject: Re: Partitioning or blkid issue?
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,
Thanks for the suggestion. I tried that fix and it didn't seem to
help. I went ahead and wiped the disk partitioning information (using
`wipefs`) and conforming that it was wiped. I reinstalled Windows and
followed with Debian Linux and find the same situation.
I'm not sure where this went wrong.

On Mon, Dec 17, 2018 at 3:14 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Fri, Dec 14, 2018 at 11:53:52AM -0600, Hank Barta wrote:
> > I have an issue where `gparted` seems to display incorrect information
> > on my system drive (and `parted` seems to report correct information.)
> > I filed a bug on Launchpad (since this manifests on Ubuntu 18.10)
> > https://bugs.launchpad.net/ubuntu/+source/gparted/+bug/1808421 and was
> > directed to https://gitlab.gnome.org/GNOME/gparted/issues/14 which
> > does appear to be the same issue. Near the end of the first link is
> > information I collected when running Ubuntu 18.04 (from `blkid` and
> > `wipefs`)
> >
> > I have found that when this system is running Debian Stretch from USB
> > that `gparted` appears to produce the correct output. Below is the
> > same information collected when running Debian Stretch.
> >
> > root@debian:/home/user# apt policy util-linux
> > util-linux:
> >   Installed: 2.29.2-1+deb9u1
> >   Candidate: 2.29.2-1+deb9u1
> >   Version table:
> >  *** 2.29.2-1+deb9u1 500
> >         500 http://deb.debian.org/debian stretch/main amd64 Packages
> >         100 /var/lib/dpkg/status
> > root@debian:/home/user# blkid /dev/sda
> > /dev/sda: LABEL="rpool" UUID="4510611204828545482"
> > UUID_SUB="9816084798696086204" TYPE="zfs_member"
> > PTUUID="eba09d2e-0f70-4d11-8e37-c1c170cfd9dd" PTTYPE="gpt"
> > root@debian:/home/user# wipefs --no-act /dev/sda
> > offset               type
> > ----------------------------------------------------------------
> > 0x200                gpt   [partition table]
> >
> > 0xe8e0d3f000         zfs_member   [filesystem]
> >                      LABEL: rpool
> >                      UUID:  4510611204828545482
> >
> > root@debian:/home/user#
> >
> > I would like to know if this identifies a problem in the partition
> > table or an issue with `blkid`. (Or something else?)
> > I don't think I installed a ZFS pool on the entire disk but I could be
> > wrong about that. It is also possible that one of my operations did
> > cause a problem with the partition table.
>
> It seems like disk originally formatted as ZFS has been later
> partitioned by GPT.
>
> In this case it does not seem like false positive ZFS detection. You
> need ZFS magic string and guid= (aka UUID_SUB), pool_guid= (aka UUID)
> and name= (aka LABEL) variable names and data on the right offsets.
>
> > This is a test system and relatively new install so it would not be a
> > huge problem to 'nuke and repave' if that is necessary to fix this or
> > to try anything that can further identify the problem.
> >
> > Suggestions on what I should do next are most welcome!
>
> The ideal is to use partitioning tools that wipe the disk before it
> writes partition table. Or use "wipefs -a" to cleanup all from the
> disk before you use it (this is recommended step during system
> installation).
>
> For now you can use "wipefs -o 0xe8e0d3f000" to remove only the
> unwanted ZFS stuff.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com



-- 
'03 BMW F650CS - hers
'98 Dakar K12RS - "BABY K" grew up.
'93 R100R w/ Velorex 700 (MBD starts...)
'95 Miata - "OUR LC"
polish visor: apply squashed bugs, rinse, repeat
Beautiful Sunny Winfield, Illinois
