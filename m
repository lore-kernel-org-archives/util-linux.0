Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61471 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbaDOMUH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 08:20:07 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so9622340pad.0
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 05:20:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1397560535-14622-4-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
	<1397560535-14622-4-git-send-email-kerolasa@iki.fi>
Date: Tue, 15 Apr 2014 13:20:06 +0100
Message-ID: <CAG27Bk3noD2pMNiCS1ySYogLHf2rp13ZtnR597nD7cOUsRngww@mail.gmail.com>
Subject: Re: [PATCH 3/9] tests: add signal receiver program
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 15 April 2014 12:15, Sami Kerola <kerolasa@iki.fi> wrote:
> +       if (!(fd = open(pid_path, O_WRONLY | O_CREAT | O_TRUNC, mode)))

Karel,

Bernhard's comment about open() returning -1 when failing is fixed in my github.

https://github.com/kerolasa/lelux-utiliteetit/commit/125d5bebeab0727cd53f51d04cbe24ed9b18de5b#diff-437d9e619dae92130efbc0f412050818R149

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
