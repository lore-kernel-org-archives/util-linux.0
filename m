Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f49.google.com ([209.85.214.49]:33170 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeDUIOE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 21 Apr 2018 04:14:04 -0400
Received: by mail-it0-f49.google.com with SMTP id x144-v6so4924815itc.0
        for <util-linux@vger.kernel.org>; Sat, 21 Apr 2018 01:14:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <cf949a43-9027-de52-87e2-33c95605d58b@redhat.com>
References: <cf949a43-9027-de52-87e2-33c95605d58b@redhat.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 21 Apr 2018 09:14:03 +0100
Message-ID: <CAG27Bk3m7PYCMtMMV0pVAZpmMJGsGWUk0KFfpT=KD80U4QQ5ug@mail.gmail.com>
Subject: Re: lsblk '--allcols'
To: Dan Mick <dmick@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 20 April 2018 at 22:42, Dan Mick <dmick@redhat.com> wrote:
> Beyond simple "show me a quick overview", I often want to see everything
> the system knows about a blockdev, and it's a drag to have to construct
> the option list from the output of help.  I've made a simple
> "-A/--allcols" patch.  Is that something that would meet the
> expectations of the team, and if so, is email to this list the best way
> to submit it?

Pardon if I sound confused. Subject line says lsblk that already has
display all columns option:

 -O, --output-all     output all columns

In message body you are talking about blockdev, that has it's place
but lsblk is better reporting tool. Assuming lsblk does not list something
blockdev can then I recommend adding that to lsblk.

That said --allcols proposal has a point. Right now various tools
that use smartcols has the options listed below. Perhaps --output-all
should be part of these.

 -J, --json             use JSON output format
 -n, --noheadings       don't print headings
 -o, --output <list>    COLUMNS to display (see below)
 -r, --raw              use the raw output format

If I see right the --output-all could be added to these utilities: fdisk,
fincore, findmnt, losetup, lscpu, lsipc, lslocks, lslogins, lsmem, lsns,
partx, prlimit, rfkill, sfdisk, swapon, uuidparse, wdctl, wipefs, and
zramctl.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
