Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64360 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLZN61 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 26 Dec 2014 08:58:27 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so17098531wid.15
        for <util-linux@vger.kernel.org>; Fri, 26 Dec 2014 05:58:25 -0800 (PST)
Received: from kerolasa-home (host-84-13-166-100.opaltelecom.net. [84.13.166.100])
        by mx.google.com with ESMTPSA id ju2sm5182762wid.7.2014.12.26.05.58.24
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Dec 2014 05:58:24 -0800 (PST)
Date: Fri, 26 Dec 2014 13:58:20 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/14] script: add struct script_control and remove global
 variables
In-Reply-To: <1419248837-4619-15-git-send-email-kerolasa@iki.fi>
Message-ID: <alpine.LNX.2.03.1412261354090.9055@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi> <1419248837-4619-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 22 Dec 2014, Sami Kerola wrote:
>  	line[strlen("/dev/")] = 't';

The above is incorrect.  Following fix can be found from my github 
'script' branch.

@@ -423,7 +423,7 @@ static void dooutput(struct script_control *ctl)
 static void getslave(struct script_control *ctl)
 {
 #ifndef HAVE_LIBUTIL
-       line[strlen("/dev/")] = 't';
+       ctl->line[strlen("/dev/")] = 't';

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
