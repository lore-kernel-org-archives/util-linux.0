Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023Ab3EFRTn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 May 2013 13:19:43 -0400
Date: Mon, 6 May 2013 19:19:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: [PATCH 09/16] cal: add --highligth option which uses argmatch
Message-ID: <20130506171930.GD9740@x2.net.home>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
 <1367520701-14962-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1367520701-14962-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 02, 2013 at 07:51:34PM +0100, Sami Kerola wrote:
>  	static const struct option longopts[] = {
>  		{"one", no_argument, NULL, '1'},
>  		{"three", no_argument, NULL, '3'},
> @@ -263,6 +282,7 @@ main(int argc, char **argv) {
>  		{"monday", no_argument, NULL, 'm'},
>  		{"julian", no_argument, NULL, 'j'},
>  		{"year", no_argument, NULL, 'y'},
> +		{"highlight", required_argument, NULL, OPT_HIGHLIGHT},

 I agree with Pádraig, --color seems better and extendible.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
