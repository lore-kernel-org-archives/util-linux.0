Return-Path: <SRS0=5fi4=VP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DBC7618F
	for <util-linux@archiver.kernel.org>; Thu, 18 Jul 2019 20:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C12173B
	for <util-linux@archiver.kernel.org>; Thu, 18 Jul 2019 20:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BganeeFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfGRUKi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:10:38 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34787 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRUKi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 Jul 2019 16:10:38 -0400
Received: by mail-yb1-f193.google.com with SMTP id x32so11789606ybh.1
        for <util-linux@vger.kernel.org>; Thu, 18 Jul 2019 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h0ZuPtQJsTnGkKDNkzM8ZF+kj+fyO0/BWBeq8YU5cqs=;
        b=BganeeFgh+fIcgghXsieFzy/dEsb2W2wUyeUQj0G/DSIK8eg7Nks40hCxN7iLU1NTI
         RnwriQk/24Ri2pUcswQ+lKEEaY9RWCbIbyYc81Qf9SHvCp2wyXsXB4jMLNk0HX3LOdS7
         9MFFtI3WNm6J6fu7jTSjTJKNYk23698fwFcv7i3l6sSbHS+egIIYGi39I7mUNw2la0qQ
         Gp5321AgHO6d8EV1tnN+F87v7vpaEp4A5qaVlaVOztF81kEuVmWH5WRv5ibAn56xiJKx
         qaqKmTEtbwsnfhQk8YlBVbKGVq+5O8uO0GT4JEcfcDEdJx/d0URQzoSQljYKNhPVy05w
         ji5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h0ZuPtQJsTnGkKDNkzM8ZF+kj+fyO0/BWBeq8YU5cqs=;
        b=b/evShMDoL1jF+f0DGZsJ/cfqnFVL0fBwmjn2gAKisfFRPv5VHlpFnGD9mZD9AGjIL
         sgfyFoBWwTzMH710HhiiiCRtIJb6c7cXPIdGh0M+It/Ajbj5eOp9hFK7Iw8Y8Vd7f7IE
         EQlmQeNKoCpAL3MQ62SQeIe/kui/6qYto3p8lZKTURqCynL8ow2dSrXrzKm7nE5mlCs+
         ngyzd9L8DwtrzzjuJjE22zIsycNCsUxcSB0jZwkweYNw2BCRnTj2ffLDeT6MWbV+jML3
         yRMeidB+0COKZs7QEve5RJ01gwVVWqn2PSdS+uK0LrBmCt72NPYZXbx5aBK9ZMBmnCo3
         UxyA==
X-Gm-Message-State: APjAAAW8dDnh2urREyfbGk04Vf9RQZZyyhHFQAP2/OV2OfQ931Da3e7T
        QMFSPZVVV8SENbKZR/R1Rnlaw42m5ZI5Js8cR0M=
X-Google-Smtp-Source: APXvYqz92dtN47BV12jXKOwUHUanpkRQrroeFGEIPaI/MXhBiJeHxOlzJDoHSrhSTopFEiW5BRV2ws0GM04AllYsB14=
X-Received: by 2002:a25:80d3:: with SMTP id c19mr27588368ybm.259.1563480637830;
 Thu, 18 Jul 2019 13:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMU1PDhRJRwawuSZ3x+NEAQx47afOhcSUw6wTsdcbNoz4th1hA@mail.gmail.com>
 <20190717111611.dfkjvyuvpuipfsmy@ws.net.home>
In-Reply-To: <20190717111611.dfkjvyuvpuipfsmy@ws.net.home>
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Thu, 18 Jul 2019 21:10:26 +0100
Message-ID: <CAMU1PDgYUdkWE3Vd2hOWT5Rp0Bycq6s0U81=6zxERapsBzqa5Q@mail.gmail.com>
Subject: Re: blkid identifying whole disk ntfs as both ntfs and msdos
 partition table
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 17 Jul 2019 at 12:16, Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Jul 02, 2019 at 11:43:34AM +0100, Mike Fleetwood wrote:
> > # mkntfs -Q -F /dev/sdb
> > /dev/sdb is entire device, not just one partition.
> > mkntfs forced anyway.
> > Cluster size has been automatically set to 4096 bytes.
> > Creating NTFS volume structures.
> > mkntfs completed successfully. Have a nice day.
> > # ./blkid --version
> > lt-blkid from util-linux 2.34.24-e3bb9  (libblkid 2.34.24, 14-Jun-2019)
> > # ./blkid /dev/sdb
> > /dev/sdb: UUID=3D"3B64D28A5CF89146" TYPE=3D"ntfs" PTTYPE=3D"dos"
>
> Fixed version:
>
>  # ./blkid -p /dev/sdc
>  /dev/sdc: UUID=3D"18CBAEE61457A850" TYPE=3D"ntfs" USAGE=3D"filesystem"
>
> > # ./wipefs /dev/sdb
> > DEVICE OFFSET TYPE UUID             LABEL
> > sdb    0x3    ntfs 3B64D28A5CF89146
> > sdb    0x1fe  dos
>
> wipefs has a little bit different semantic, it tries to gather as
> much as possible magic strings, so after the bug fix it still reports
> "dos" on 0x1fe. It's expected behavior.
>
> wipefs internally masks previously detected magic string (e.g. "ntfs")
> to avoid any interaction with the next probing. This is because we
> want to see all possibilities. Note wipefs wipes only the magic
> strings (and nothing else), so if you wipe "NTFS" than it will be
> interpreted as MBR ("dos") as there is no more valid NTFS.
>
> > Note that the test ntfs image in util-linux doesn't cause this.  Just f=
ile
> > systems created by mkntfs from ntfsprogs.
> >
> > # dd if=3D/dev/zero bs=3D1M of=3D/dev/sdb
> > # xzcat tests/ts/blkid/images-fs/ntfs.img.xz > /dev/sdb
> > # ./blkid /dev/sdb
> > /dev/sdb: LABEL=3D"M-PM-^]M-PM->M-PM-2M-QM-^KM-PM-9 M-QM-^BM-PM->M-PM-<=
"
> > UUID=3D"09CBB6DE30C87310" TYPE=3D"ntfs"
> > # ./wipefs /dev/sdb
> > DEVICE OFFSET TYPE UUID             LABEL
> > sdb    0x3    ntfs 09CBB6DE30C87310 =D0=9D=D0=BE=D0=B2=D1=8B=D0=B9 =D1=
=82=D0=BE=D0=BC
>
> Sounds like we need another test image :-)
>
>
> Thanks for your reports!
>
>     Karel

Thank you for fixing these bugs so quickly.

Mike
