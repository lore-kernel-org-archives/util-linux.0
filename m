Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f172.google.com ([209.85.220.172]:47637 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaJGLww convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Oct 2014 07:52:52 -0400
Received: by mail-vc0-f172.google.com with SMTP id lf12so4597563vcb.31
        for <util-linux@vger.kernel.org>; Tue, 07 Oct 2014 04:52:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5433CE48.7060507@gmx.com>
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com> <5433CE48.7060507@gmx.com>
From: =?UTF-8?Q?No=C3=A9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
Date: Tue, 7 Oct 2014 13:52:22 +0200
Message-ID: <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing clock
To: JWP <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

> I just submitted a patch on 14-09-27 that adds this functionality
> without creating a new state file.

Nice! I guess this is the patchset:
<http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/9918>

However I am not sure how those patches adds the functionality I am
looking for. Can you explain how you would use hwclock to get and set
the time without a write access to the hardware clock?

Regards,
Noé.
