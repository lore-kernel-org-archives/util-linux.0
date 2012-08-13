Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2HMN0A (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Aug 2012 09:26:00 -0400
Date: Mon, 13 Aug 2012 15:25:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix non-Linux build
Message-ID: <20120813132546.GB21956@x2.net.home>
References: <20120808151943.GR10080@type.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120808151943.GR10080@type.famille.thibault.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 08, 2012 at 05:19:43PM +0200, Samuel Thibault wrote:
> --- a/lib/cpuset.c
> +++ b/lib/cpuset.c
> @@ -54,6 +54,7 @@ static const char *nexttoken(const char *q,  int sep)
>  	return q;
>  }
>  
> +#ifdef __linux__
>  /*
>   * Number of bits in a CPU bitmask on current system
>   */
> @@ -85,6 +86,7 @@ int get_max_number_of_cpus(void)
>  	}
>  	return -1;
>  }
> +#endif

 Hmm... this not too elegant for the internal API. I have modified the
 patch:

--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -59,6 +59,7 @@ static const char *nexttoken(const char *q,  int sep)
  */
 int get_max_number_of_cpus(void)
 {
+#ifdef SYS_sched_getaffinity
        int n, cpus = 2048;
        size_t setsize;
        cpu_set_t *set = cpuset_alloc(cpus, &setsize, NULL);
@@ -83,6 +84,7 @@ int get_max_number_of_cpus(void)
                cpuset_free(set);
                return n * 8;
        }
+#endif
        return -1;
 }


... so the function always exist. I guess the syscall is Linux
specific.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
