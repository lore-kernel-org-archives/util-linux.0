Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:19811 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab3D2AeQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 20:34:16 -0400
Message-ID: <517DBDB7.8090506@draigBrady.com>
Date: Mon, 29 Apr 2013 01:24:23 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 08/11] cal: allow day highlight testing
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi> <1367169067-23705-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-9-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/28/2013 06:11 PM, Sami Kerola wrote:
> Requires similar trick as done with more to by pass check whether a
> session is or isn't interactive.

I wonder should we have an option or env variable to force highlighting?
I've wanted a couple of times to pipe output like:
  cal --color=always | ansi2html.sh

cheers,
Pádraig.
