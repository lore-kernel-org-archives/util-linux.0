Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbcCRKsD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 06:48:03 -0400
Date: Fri, 18 Mar 2016 11:48:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: util-linux@vger.kernel.org, qcai@redhat.com
Subject: Re: [PATCH 1/1] lscpu: correct the Virtualization type on Xen DomU
 PV guest
Message-ID: <20160318104801.siebyw4cdsxtpwqm@ws.net.home>
References: <1458284004-17357-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458284004-17357-1-git-send-email-dongli.zhang@oracle.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 18, 2016 at 02:53:24PM +0800, Dongli Zhang wrote:
> +			fd = path_fopen("r", 0, _PATH_SYS_HYP_FEATURES);

 Is the file always available (including old XEN versions)? This
 function exit on error, maybe we need path_exist() before open.

 There is also path_read_u64() to avoid path_fopen() & fscanf().

    Karel

> +			if (fd && fscanf(fd, "%x", &features) == 1) {
> +				/* Xen para-virt (or pvh) */
> +				if (!(features & (1U << XENFEAT_hvm_pirqs)))
> +					desc->virtype = VIRT_PARA;
> +				fclose(fd);
> +			}
> +		}
> +	} else if (read_hypervisor_powerpc(desc) > 0) {}
>  
>  	/* Xen para-virt or dom0 */
>  	else if (path_exist(_PATH_PROC_XEN)) {

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
