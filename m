Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:43603 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753254Ab2B0RQF convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Feb 2012 12:16:05 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "dave@gnu.org" <dave@gnu.org>, Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Mon, 27 Feb 2012 18:16:02 +0100
Subject: RE: [PATCH v3 3/4] lslocks: new command
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0AFAD64D@MCHP058A.global-ad.net>
References: <1330357315.2540.5.camel@offbook>
In-Reply-To: <1330357315.2540.5.camel@offbook>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:


> +static char *get_cmdname(pid_t pid)
> +{
> +	FILE *fp;
> +	char path[PATH_MAX];
> +
> +	sprintf(path, "/proc/%d/comm", pid);
> +	if (!(fp = fopen(path, "r")))
> +		return NULL;
> +
> +	/* just need the first line */
> +	if (!fgets(path, sizeof(path), fp))
> +		goto out;
> +out:

this looks strange to me:
if fgets fails, then we want to ...

> +	fclose(fp);

... but certainly not this:

> +	path[strlen(path) - 1] = '\0';
> +	return xstrdup(path);
> +}

Have a nice day,
Berny
