Return-Path: <SRS0=xh3B=7C=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CDC433DF
	for <util-linux@archiver.kernel.org>; Wed, 20 May 2020 06:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D71207FB
	for <util-linux@archiver.kernel.org>; Wed, 20 May 2020 06:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTfSiLN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgETGbI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 May 2020 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGbI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 20 May 2020 02:31:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862EC061A0E
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 23:31:07 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so1995048ejq.5
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=Hak0KnM4xilba29xhZSYBUMyUukoZTUbi+PsmWRAE3w=;
        b=UTfSiLN/GtjKv5Y+epPiq0iXkVQ8TCOMV7uw1NHm4Fks7eWLAlywRc9rhkGy9bC/eX
         MM/Owsr5x0Nr82uUavNxhRFUyBoasPtd7BZXN65rPviDqglXTykMP6QXOuXaTXb3MTVG
         yKryErBxYHE1ns3dVPBJVt7d52kHHZgkxyZ2BT96UMQ+er/UkVu3x7vYk6wSJLzqwgCb
         NInFmCuDbYkaGwmlEnVC4QZ8HPcbO2omtewP5BGI+7/FbefOJ+hRKETA/3s3kAuLG8ra
         uI4Je2pnwN6ahmCo6Y/ThplRLTlBsIVXhwSpd7EGSAmjPEcwAP04H8O387nZWCM81fnN
         Hchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Hak0KnM4xilba29xhZSYBUMyUukoZTUbi+PsmWRAE3w=;
        b=adVfV6fMz9TOJdFEanv7SvzXubt6tiQRFD/fYrNSQ7zwkXe2yFiTV7nR5O7CJvjEjU
         oXGF+y5P1cA3drJuhY8GZKyvkSkfho/nrUO5Rodu3uXhNuXsB36VVi4CQ/lA0GySDQLv
         XigXp9HII2cqfocwsrpNZ9l1gdgtWJ5X6l2izSk3vbOYI/3RkRqdmX1BsW4+2NtGeUaZ
         S7A3CJOHROk+1dtf0cmjikPlddDj+qU7ezxNYa1Ub4fDqzA8ovZdYf0Yfl065xgbFve6
         5oxxD8K7lgcGZsbyl68Bnp7vF9uR7oMoD5m5pnjzju13a2cSHHEbKtzHkUrsydxhvIrk
         BD+Q==
X-Gm-Message-State: AOAM533yXijmTxA6Jz+XPEzyQXTqDCyNtxmMccEC2lg/zBvEWK5ZpKBv
        bcvA5q626gPQEJGkkUfDBDynyXGTicOhhtHqZX0=
X-Google-Smtp-Source: ABdhPJwGxvZlaws+dCrTexTailtQ09d6DnOxTuizY4m6G2oiE9cC31d+rVGrrzivlHRrgC6rBmCEaQXG/w+ymJyjW9Y=
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr2444343ejz.286.1589956266454;
 Tue, 19 May 2020 23:31:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 20 May 2020 08:30:55 +0200
Message-ID: <CAKgNAkjU+HdQ2PQLtrPbVU2cyUYecOZZV3i6CSeDvWJM_OR3qQ@mail.gmail.com>
Subject: Section ordering in util-linux manual pages
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Across the util-linux manual pages, and assuming you accept my patch
series from yesterday, the most common SH sections are:

    129 .SH AVAILABILITY
    129 .SH DESCRIPTION
    129 .SH NAME
    129 .SH SYNOPSIS
    113 .SH SEE ALSO
    106 .SH OPTIONS
     87 .SH AUTHORS
     34 .SH NOTES
     33 .SH EXIT STATUS
     30 .SH EXAMPLE
     29 .SH ENVIRONMENT
     24 .SH FILES
     24 .SH HISTORY
     18 .SH BUGS
      9 .SH CONFORMING TO
      7 .SH COMMANDS
      6 .SH COLORS
      6 .SH COPYRIGHT
      4 .SH ARGUMENTS
      4 .SH RETURN VALUE

However, there's quite a wild variability in the order of some of
these sections in individual pages, which can make it a little
difficult to find a section. I suggest that the order of sections
should be consistently something like:

NAME
SYNOPSIS
CONFIGURATION
DESCRIPTION
OPTIONS
EXIT STATUS
RETURN VALUE
ERRORS
ENVIRONMENT
FILES
VERSIONS
HISTORY
ATTRIBUTES
CONFORMING TO
NOTES
BUGS
EXAMPLE
AUTHORS
COPYRIGHT
SEE ALSO
AVAILABILITY

(Note that this list does not include all the sections listed above,
but I'll ignore those for the moment.)

Does that order sound reasonable to you. (It's an expanded version of
the suggested order in man-pages(7), with some additions to allow for
headings that are commonly used in util-linux manual pages.)

I'd like to send some patches to fix that ordering. I would not do
this all at once, but rather, one or section headers at a time,
probably starting with SEE ALSO/AVAILABILITY. Does this sound okay to
you?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
