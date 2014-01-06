Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbaAFP5W (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 10:57:22 -0500
Date: Mon, 6 Jan 2014 16:57:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org, qcai@redhat.com
Subject: Re: [PATCH 1/1] lscpu: support discontinuous NUMA nodes
Message-ID: <20140106155718.GH31045@x2.net.home>
References: <1388655877-18492-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388655877-18492-1-git-send-email-maddy@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 02, 2014 at 03:14:37PM +0530, Madhavan Srinivasan wrote:
> lscpu fails to print proper NUMA node values in a system
> with discontinuous nodes. This patch adds support by
> creating a nodeidx array to map node numbers.

Good idea. It would be also nice to have a /sys dump from system
with discontinuous nodes. You can generate the dump by

  tests/ts/lscpu/mk-input.sh  foo

and send me foo.tar.gz. I'll add the dump to lscpu(1) regression
tests.

>  sys-utils/lscpu.c |   47 +++++++++++++++++++++++++++++++++++++++++------

I have applied a little different patch..

> +static int
> +check_for_dir(const char *path, const char *file_name)
> +{
> +	char buf[100];
> +	struct stat file;
> +
> +	sprintf(buf, "%s/%s", path, file_name);

this is exactly reason why we have openat/statat/... functions.

> +	return stat(buf, &file) == 0 && S_ISDIR(file.st_mode);
> +}

>  static void
>  read_nodes(struct lscpu_desc *desc)
>  {
> -	int i;
> +	int i=0;
> +	DIR *dir=NULL;
> +	struct dirent *curdir=NULL;
>  
>  	/* number of NUMA node */
> -	while (path_exist(_PATH_SYS_SYSTEM "/node/node%d", desc->nnodes))
> -		desc->nnodes++;
> +	dir=opendir(_PATH_SYS_NODE);
> +	if(dir) {
> +		while ((curdir = readdir(dir)) != NULL) {
> +			if((strncmp(curdir->d_name, "node", 4) == 0) &&
> +			    check_for_dir(_PATH_SYS_NODE, curdir->d_name) &&

 anyway, you can use dirent->d_type to avoid unnecessary stat()

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
