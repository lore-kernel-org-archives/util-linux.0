Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:50627 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab3GHUWW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Jul 2013 16:22:22 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so4105812wes.31
        for <util-linux@vger.kernel.org>; Mon, 08 Jul 2013 13:22:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1373226889-3451-4-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi> <1373226889-3451-4-git-send-email-kerolasa@iki.fi>
From: Kay Sievers <kay@vrfy.org>
Date: Mon, 8 Jul 2013 22:21:58 +0200
Message-ID: <CAPXgP11cHR9HzB9_pSERb9i=V0dpXUzcGY40BRbb37Lycpe3sQ@mail.gmail.com>
Subject: Re: [PATCH 03/34] include: copy unlocked-io.h from gnulib
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 7, 2013 at 9:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> At the moment util-linux command are not threading, which means they can
> safely use thread-unsafe IO system calls which should make printing
> quicker.

Do you have numbers about the assumption that this will produce better
results on Linux?

Uncontended mutexes/futexes on Linux probably might not really show
up. Maybe in inner loops, not sure. Would be nice to know ...

Kay
