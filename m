Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25234 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab2GZJpo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 05:45:44 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6Q9jika019203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 05:45:44 -0400
Date: Thu, 26 Jul 2012 11:45:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsblk: add read-ahead column.
Message-ID: <20120726094542.GC17589@x2.net.home>
References: <1343140473-15035-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343140473-15035-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 24, 2012 at 04:34:33PM +0200, Milan Broz wrote:
>  misc-utils/lsblk.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

> @@ -1333,6 +1340,7 @@ int main(int argc, char *argv[])
>  			columns[ncolumns++] = COL_ROTA;
>  			columns[ncolumns++] = COL_SCHED;
>  			columns[ncolumns++] = COL_RQ_SIZE;
> +			columns[ncolumns++] = COL_RA;
>  			break;

So -t output has been changed... I have added to the man page:

  The default output as well as default output from options like
  --topology and --fs is subject to change, so whenever possible you
  should  avoid using  default  outputs  in  your scripts.  Always
  explicitly  define  expected columns by '--output columns' in
  environment where a stable output is required.

it seems that we need this in all our new utils (findmnt, lslocks,
partx, ...) where is --output option. I think it's good idea to force
users to write robust scripts :-)

Comments?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
