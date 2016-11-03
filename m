Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.magicbluesmoke.com ([82.195.144.49]:51804 "EHLO
        mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcKCMJo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Nov 2016 08:09:44 -0400
Subject: Re: [PATCH] tests: wait for flock background process
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
References: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de>
 <13b5d77f-87e6-3303-bb5d-e311cb303cfd@bernhard-voelker.de>
 <20161102230828.n2rlorlyf4rwjiqc@ws.net.home>
 <201611030757.09823.sweet_f_a@gmx.de>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <af628f12-2b1a-fbbb-2c8a-535f714693c7@draigBrady.com>
Date: Thu, 3 Nov 2016 12:09:40 +0000
MIME-Version: 1.0
In-Reply-To: <201611030757.09823.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/11/16 06:57, Ruediger Meier wrote:
> To replace sleep for floats, we could check and use usleep(1) from 
> sysvinit. Or we could even add usleep to util-linux as we did with 
> other sysvinit commands.

I previously suggested this technique to kernel folks,
who use it in linux kernel tests:

  yield() { sleep .001 || usleep 1 || sleep 1; }

cheers,
Pádraig.
