Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63957 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbaKBUOb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:14:31 -0500
Received: by mail-pd0-f169.google.com with SMTP id y10so10341485pdj.28
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:14:30 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1414799828-23380-1-git-send-email-kerolasa@iki.fi>
References: <1414799828-23380-1-git-send-email-kerolasa@iki.fi>
Date: Sun, 2 Nov 2014 20:14:30 +0000
Message-ID: <CAG27Bk3zQCXR-nZX=t3epDoq-qXYFExFGYN9WXY__vNUDKeQOg@mail.gmail.com>
Subject: Re: [PATCH] swapoff: make LABEL= and UUID= work when turning off swap files
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 31 October 2014 23:57, Sami Kerola <kerolasa@iki.fi> wrote:
> Before this commit the swapoff was unable to find swap files by UUID or
> LABEL.  For example if one had:

Karel, please ignore this change. This version is not good enough.
I'll send new along with mkswap changes.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
