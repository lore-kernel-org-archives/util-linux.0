Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19425 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab2GXLlC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:41:02 -0400
Date: Tue, 24 Jul 2012 13:40:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 09/10] fdisk: API: fix fdisk_label_create
Message-ID: <20120724114057.GF736@x2.net.home>
References: <1342976745.2863.19.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342976745.2863.19.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 22, 2012 at 07:05:45PM +0200, Davidlohr Bueso wrote:
> +	} else
> +		errcode = fdisk_label_change(cxt, name);
> +
> +	if (errcode)
> +		goto done;
> +
> +	errcode = cxt->label->create_label(cxt);
>  done:
>  	return errcode;

 Unnecessary for the current code.

    karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
