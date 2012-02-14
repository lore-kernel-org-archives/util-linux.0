Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:34099 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756536Ab2BNLQO convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Feb 2012 06:16:14 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "dave@gnu.org" <dave@gnu.org>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Tue, 14 Feb 2012 12:16:11 +0100
Subject: RE: [PATCH 2/4] sys-utils: fix typos
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D8E334D5D@MCHP058A.global-ad.net>
References: <1329217994.3269.6.camel@offbook>
In-Reply-To: <1329217994.3269.6.camel@offbook>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

> diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
> -		warnx(_("File %s, For threshold value %lu and timrout value %lu, Maximum characters in fifo were %d,\n"
> +		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"

why "Maximum" upper-case?

Berny