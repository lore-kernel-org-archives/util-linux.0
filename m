Return-Path: util-linux-owner@vger.kernel.org
Received: from midir.magicbluesmoke.com ([82.195.144.46]:55246 "EHLO
        mail.magicbluesmoke.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752138AbdC2C5n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 28 Mar 2017 22:57:43 -0400
Subject: Re: col issue
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
Cc: Sami Kerola <kerolasa@iki.fi>
From: =?UTF-8?Q?P=c3=a1draig_Brady?= <P@draigBrady.com>
Message-ID: <1a5ce781-a9c9-11ef-d3d2-45f95d9cd7a8@draigBrady.com>
Date: Tue, 28 Mar 2017 19:57:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28/03/17 05:16, Karel Zak wrote:
> 
>  Hi,
> 
>  see https://bugzilla.redhat.com/show_bug.cgi?id=1436432
> 
>  any idea what is the right col(1) behavior for escape sequences?
> 
>  The current code reads two first bytes from the sequence and the rest
>  is interpreted as standard chars (because complex sequences like
>  ^[..m are completely unknown for the code), for example input:
> 
>     ^[[1mtomcat-el^[(B^[[m
> 
>  produces:
> 
>     1mtomcat-elBm
> 
>  It seems incorrect. I think for "col -p" all the sequence should be
>  filtered out, it means:
>    
>     tomcat-el
>  
>  and the default behavior (without -p) should be output all escape
>  sequences but do not increment internal width counters.
>  
>  Objections?
> 
>     Karel
> 

I agree, but presuming you meant the opposite, and
for `col -p` to pass through all these escape sequences unaltered
