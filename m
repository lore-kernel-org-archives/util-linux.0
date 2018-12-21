Return-Path: <SRS0=8g6v=O6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF73AC43387
	for <util-linux@archiver.kernel.org>; Fri, 21 Dec 2018 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EC7218FD
	for <util-linux@archiver.kernel.org>; Fri, 21 Dec 2018 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLU3TCYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbeLUGay (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:30:54 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:40250 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbeLUGax (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 21 Dec 2018 01:30:53 -0500
Received: by mail-it1-f170.google.com with SMTP id h193so5173977ita.5
        for <util-linux@vger.kernel.org>; Thu, 20 Dec 2018 22:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTQgSp3DaO3ZRigYNir1inZp0jbe6Xp37wHcO0vzFkM=;
        b=RLU3TCYfolVvHAcia9u60iQqslJXRd/qsTQrrhBaeUJVLzumbywEKFkEzr88Ke65iS
         WI6ZnpHn51a/jzv1QuQneNWXwlgTIXz+JD3TIhScppzDXYeFRXlzfJgNoYp3rsPsDMyO
         0hY05325JBfKw4MWO4lZhbWS9bEn66j/bhUe2CXlsjZkM1y5H923FEKVWd+oDPl8mRdl
         Ub+bqxYgYjhiBDvC1jJ/7WLL82u727PPvgGwzMvSTK3/ceFlnHwYT6bRDBJ7eHAvoHz1
         66t3WxugkcDbus+AChNlPhxTVtS3gi9qxEeH1DtywGhnCThEO4a3Tr7NG5ap2PI0DvjY
         KnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTQgSp3DaO3ZRigYNir1inZp0jbe6Xp37wHcO0vzFkM=;
        b=pJ+3gkf8jXMzvjaZ2QFUNJYLUDDD74XBpHAbC4DNzKTbCqvjE3wVEOFPJ8K2cM2/Hl
         GeKrO9T/wJvY+bNBhKvxZx47yKwbWh0gBiyl64Cl38Xx+o4MuGW7dZpg2rQ0RF4KxyKN
         AaQ/1XBc8Tg6UiWCx07nuiCGfnhmqiBANT0owKv0QK7STRVQJsuoDSUyqsQx/kMXEf+G
         iRpg185q9gzgDL+wQ6W+wdmahEh+TP5eYSUKBSKCTlxsqKEZ4SylpZxpN76Ezg+G/Kuu
         3zHbjt7qd5vDeMnwaqZF7b0S/5aYqVyVXgw8RLh9aFB558lO0P8tHDZxd5pIvCjXwx/4
         OXbA==
X-Gm-Message-State: AA+aEWbfD1q20skdie4yOTSnXxYcAZcbYD4VAfIAHYsxf9Fy8y02o7N8
        ZF5l8pPbaVnljexANqisxWycYgn5AKd1ZrwDKD0=
X-Google-Smtp-Source: AFSGD/VQGWejL7/jKVUc5yOxnkfCsNNeXwzjA1kFyyjRqp8MScoKGSOegaUioBi4O5tGK7snJOPNK94qjwTk/KP48m8=
X-Received: by 2002:a24:1495:: with SMTP id 143mr1120413itg.13.1545373852920;
 Thu, 20 Dec 2018 22:30:52 -0800 (PST)
MIME-Version: 1.0
References: <CABTDG89z-g=LmHobptPBmYVzTucz_ZWrPo4yo_Gh7O9ZEQAqfQ@mail.gmail.com>
 <20181217091421.zcj3f3bfe3ps6mpu@ws.net.home> <CABTDG889Zmk-TOnj9YzGn0ffiU3Nu3FB0gC=yYcYVyB4pMORjw@mail.gmail.com>
In-Reply-To: <CABTDG889Zmk-TOnj9YzGn0ffiU3Nu3FB0gC=yYcYVyB4pMORjw@mail.gmail.com>
From:   Hank Barta <hbarta@gmail.com>
Date:   Fri, 21 Dec 2018 00:30:41 -0600
Message-ID: <CABTDG8_4JEMn8O4QGseVMNaf8-JcOgU1Yx=ONxrGKnHJJFdS1Q@mail.gmail.com>
Subject: Re: Partitioning or blkid issue?
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Never mind - mistake on my part.

On Thu, Dec 20, 2018 at 10:26 PM Hank Barta <hbarta@gmail.com> wrote:
>
> Hi Karel,
> Thanks for the suggestion. I tried that fix and it didn't seem to
> help. I went ahead and wiped the disk partitioning information (using
> `wipefs`) and conforming that it was wiped. I reinstalled Windows and
> followed with Debian Linux and find the same situation.
> I'm not sure where this went wrong.
>
> On Mon, Dec 17, 2018 at 3:14 AM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Fri, Dec 14, 2018 at 11:53:52AM -0600, Hank Barta wrote:
> > > I have an issue where `gparted` seems to display incorrect information
> > > on my system drive (and `parted` seems to report correct information.)
> > > I filed a bug on Launchpad (since this manifests on Ubuntu 18.10)
> > > https://bugs.launchpad.net/ubuntu/+source/gparted/+bug/1808421 and was
> > > directed to https://gitlab.gnome.org/GNOME/gparted/issues/14 which
> > > does appear to be the same issue. Near the end of the first link is
> > > information I collected when running Ubuntu 18.04 (from `blkid` and
> > > `wipefs`)
> > >
> > > I have found that when this system is running Debian Stretch from USB
> > > that `gparted` appears to produce the correct output. Below is the
> > > same information collected when running Debian Stretch.
> > >
> > > root@debian:/home/user# apt policy util-linux
> > > util-linux:
> > >   Installed: 2.29.2-1+deb9u1
> > >   Candidate: 2.29.2-1+deb9u1
> > >   Version table:
> > >  *** 2.29.2-1+deb9u1 500
> > >         500 http://deb.debian.org/debian stretch/main amd64 Packages
> > >         100 /var/lib/dpkg/status
> > > root@debian:/home/user# blkid /dev/sda
> > > /dev/sda: LABEL="rpool" UUID="4510611204828545482"
> > > UUID_SUB="9816084798696086204" TYPE="zfs_member"
> > > PTUUID="eba09d2e-0f70-4d11-8e37-c1c170cfd9dd" PTTYPE="gpt"
> > > root@debian:/home/user# wipefs --no-act /dev/sda
> > > offset               type
> > > ----------------------------------------------------------------
> > > 0x200                gpt   [partition table]
> > >
> > > 0xe8e0d3f000         zfs_member   [filesystem]
> > >                      LABEL: rpool
> > >                      UUID:  4510611204828545482
> > >
> > > root@debian:/home/user#
> > >
> > > I would like to know if this identifies a problem in the partition
> > > table or an issue with `blkid`. (Or something else?)
> > > I don't think I installed a ZFS pool on the entire disk but I could be
> > > wrong about that. It is also possible that one of my operations did
> > > cause a problem with the partition table.
> >
> > It seems like disk originally formatted as ZFS has been later
> > partitioned by GPT.
> >
> > In this case it does not seem like false positive ZFS detection. You
> > need ZFS magic string and guid= (aka UUID_SUB), pool_guid= (aka UUID)
> > and name= (aka LABEL) variable names and data on the right offsets.
> >
> > > This is a test system and relatively new install so it would not be a
> > > huge problem to 'nuke and repave' if that is necessary to fix this or
> > > to try anything that can further identify the problem.
> > >
> > > Suggestions on what I should do next are most welcome!
> >
> > The ideal is to use partitioning tools that wipe the disk before it
> > writes partition table. Or use "wipefs -a" to cleanup all from the
> > disk before you use it (this is recommended step during system
> > installation).
> >
> > For now you can use "wipefs -o 0xe8e0d3f000" to remove only the
> > unwanted ZFS stuff.
> >
> >     Karel
> >
> > --
> >  Karel Zak  <kzak@redhat.com>
> >  http://karelzak.blogspot.com
>
>
>
> --
> '03 BMW F650CS - hers
> '98 Dakar K12RS - "BABY K" grew up.
> '93 R100R w/ Velorex 700 (MBD starts...)
> '95 Miata - "OUR LC"
> polish visor: apply squashed bugs, rinse, repeat
> Beautiful Sunny Winfield, Illinois



-- 
'03 BMW F650CS - hers
'98 Dakar K12RS - "BABY K" grew up.
'93 R100R w/ Velorex 700 (MBD starts...)
'95 Miata - "OUR LC"
polish visor: apply squashed bugs, rinse, repeat
Beautiful Sunny Winfield, Illinois
