Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbdF2UMg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 16:12:36 -0400
Date: Thu, 29 Jun 2017 22:12:31 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: fputs() vs puts()
Message-ID: <20170629201231.vjxp6mkecuqoalfo@ws.net.home>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <201706282129.41161.sweet_f_a@gmx.de>
 <20170629085114.66lbbszwxnooszbb@ws.net.home>
 <201706291237.19507.sweet_f_a@gmx.de>
 <20170629105313.psiy2vw63spibaan@ws.net.home>
 <4a405fc3-7afc-b1f5-e902-849d5b1699de@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4a405fc3-7afc-b1f5-e902-849d5b1699de@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 29, 2017 at 10:46:50AM -0400, J William Piggott wrote:
> >    (William, can you update your "standardize USAGE_COLUMNS" patches? Please.)
> 
> Sure, one clarification please: you want only the columns header in all
> caps? So:
> 
> Usage:
> Options:
> Functions:
> Commands:
> COLUMNS:

ha.. that's a good question. Suggestions? 

For example coreutils project uses uppercase for keywords only, for
example dd(1)

    Each FLAG symbol may be:
       ...
    Each CONV symbol may be:
       ...

it seems like original Rudi's idea

    Available COLUMNS:

it's more compatible with the rest than alone "COLUMNS". So I vote
this one.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
