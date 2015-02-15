Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:53295 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbBOMbr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Feb 2015 07:31:47 -0500
Message-ID: <54E091A1.10404@bernhard-voelker.de>
Date: Sun, 15 Feb 2015 13:31:29 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: fix warning, gcc 5.0
References: <1423937550-2035-1-git-send-email-sweet_f_a@gmx.de> <1423937550-2035-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1423937550-2035-2-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/14/2015 07:12 PM, Ruediger Meier wrote:
> -					   !strncmp(argv[i+1], "-", 1) == 0) {
> +					   strncmp(argv[i+1], "-", 1) != 0) {

... or better avoid the strncmp() for 1 character at all?

Have a nice day,
Berny
