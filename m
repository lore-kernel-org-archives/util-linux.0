Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbcGSIsi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jul 2016 04:48:38 -0400
Date: Tue, 19 Jul 2016 10:48:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/13] libfdisk: collapse indentation [oclint]
Message-ID: <20160719084836.pgjmo4v45zme4rys@ws.net.home>
References: <20160717130015.31760-1-kerolasa@iki.fi>
 <20160717130015.31760-4-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160717130015.31760-4-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 17, 2016 at 02:00:05PM +0100, Sami Kerola wrote:
> -	        for (j = 0; j < i; j++)
> -	            if (lens[j]) {

> +		for (j = 0; j < i && lens[j]; j++)


 I don't think the result is the same logic.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
