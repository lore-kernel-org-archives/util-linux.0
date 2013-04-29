Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:27961 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab3D2Acx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 20:32:53 -0400
Message-ID: <517DBF96.3040409@draigBrady.com>
Date: Mon, 29 Apr 2013 01:32:22 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/11] cal: trim three month display trailing white spaces
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi> <1367169067-23705-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-11-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/28/2013 06:11 PM, Sami Kerola wrote:
> Includes fix to checks that conform earlier output practise.

I'm not sure about this.
Other output modes have trailing whitespace.
Also consider the case where you're outputting to a <pre> in a web page,
where the pre has a different bg color to the web page.
You'd want the full width output in that case.

thanks,
Pádraig.
