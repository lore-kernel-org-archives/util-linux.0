Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdEBJ0U (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 May 2017 05:26:20 -0400
Date: Tue, 2 May 2017 11:25:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH V2]lscpu: Read available CPUs max and min frequencies
Message-ID: <20170502092556.xli5bxdarbeduzcq@ws.net.home>
References: <149328816596.3522.18183659350666784285.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149328816596.3522.18183659350666784285.stgit@localhost.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 27, 2017 at 03:52:59PM +0530, Mamatha Inamdar wrote:
> +/* Read overall maximum frequency of cpu */
> +static void
> +cpu_max_mhz(struct lscpu_desc *desc, char *max_freq)
> +{
> +	int i;
> +	float cpu_freq = atof(desc->maxmhz[0]);
> +	for (i = 1; i < desc->ncpuspos; i++) {
> +		if (desc->present && CPU_ISSET(real_cpu_num(desc, i), desc->present))
> +			if(atof(desc->maxmhz[i]) > cpu_freq)
> +				cpu_freq = atof(desc->maxmhz[i]);
> +	}

 Would be better to use atof() only once?

 if (!desc->present) {
   for (i = 1; i < desc->ncpuspos; i++) {
      if (CPU_ISSET(real_cpu_num(desc, i), desc->present)) {
        float x = atof(desc->maxmhz[i]);
        if (x > cpu_freq)
            cpu_freq = x;
      }
   }
 }

 sprintf(max_freq, "%.4f", cpu_freq);


> +	sprintf(max_freq, "%.4f", cpu_freq);
> +}
> +
> +/* Read overall minimum frequency of cpu */
> +static void
> +cpu_min_mhz(struct lscpu_desc *desc, char *min_freq)
> +{
> +        int i;
> +        float cpu_freq = atof(desc->minmhz[0]);
> +        for (i = 1; i < desc->ncpuspos; i++) {
> +                if (desc->present && CPU_ISSET(real_cpu_num(desc, i), desc->present))
> +                        if(atof(desc->minmhz[i]) > cpu_freq)

  I guess this is typo, should be '<' rather than '>'.

...
     
> +	if (desc->maxmhz){
> +		cpu_max_mhz(desc, max_freq);
> +		add_summary_s(tb, _("CPU max MHz:"), max_freq);
> +	}
> +	if (desc->minmhz){
> +		cpu_min_mhz(desc, min_freq);
> +		add_summary_s(tb, _("CPU min MHz:"), min_freq);
> +	}

 You can share the same buffer and return it by the cpu_max_mhz() and
 cpu_min_mhz(), so the result will be more elegant code:

 char freq_buf[32];
 ...

 if (desc->maxmhz)
    add_summary_s(tb, _("CPU max MHz:"), cpu_max_mhz(desc, freqbuf));
 if (desc->minmhz)
    add_summary_s(tb, _("CPU min MHz:"), cpu_min_mhz(desc, freqbuf));


 :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
