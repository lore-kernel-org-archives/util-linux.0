Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46573 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbaFXWDf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Jun 2014 18:03:35 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so785374pbb.8
        for <util-linux@vger.kernel.org>; Tue, 24 Jun 2014 15:03:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <6A8340D9D5097144961EEF98758D7089A47000C9@marathon>
References: <6A8340D9D5097144961EEF98758D7089A47000C9@marathon>
Date: Tue, 24 Jun 2014 23:03:35 +0100
Message-ID: <CAG27Bk2hnApV9tRw6u3Y0GvptHO+EW2ji7CoRd7fuzvyyws-KA@mail.gmail.com>
Subject: Re: Enhancement request: logger should use FQDN
From: Sami Kerola <kerolasa@iki.fi>
To: Kodiak Firesmith <ksf@sei.cmu.edu>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 June 2014 13:53, Kodiak Firesmith <ksf@sei.cmu.edu> wrote:
> I noticed recently while using logger in some scripts that it is not
> following RFC and choosing the FQDN first if available.  This stands out for
> hosts with $PreserveFQDN in rsyslogd.conf as all other messages will use
> FQDN and logger messages will use short hostname.
> This behavior poses problems when wrangling syslog data in a correlator like
> Splunk.
>
> Sadly I'm no coder so I cannot sort out the problem and provide a patch, but
> I'm hoping one of the logger maintainers/contributors might be able to help
> out.

FYI

I started to look how to get fqdn, RFC 3164 and RFC 5424 supported. At
the moment I am thinking logger should default to RFC 5424 in future.
If someone is interested of sneak peak I keep backup laptop in github
branch below.

https://github.com/kerolasa/lelux-utiliteetit/tree/logger

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
