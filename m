Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:58908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751067AbdJBOg7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Oct 2017 10:36:59 -0400
Date: Mon, 2 Oct 2017 16:36:57 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "Yuriy M. Kaminskiy" <yumkam@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: if ENOMEDIUM and tray is open, close tray and
 retry
Message-ID: <20171002163657.559ccff0@kitsune.suse.cz>
In-Reply-To: <6685d3eb-09b9-3904-1565-2bcfdc83eac5@suse.cz>
References: <0e40cb41-a64a-93b1-0c06-620cca40a575@suse.cz>
        <f29ab5ef-753d-2ea8-e348-d53cdf4262cf@suse.cz>
        <db7a8eaa-3519-234c-72c9-428ca1b80ff0@suse.cz>
        <m3wp6u5k8z.fsf@gmail.com>
        <68bc995a-3b0c-5b2c-cb7a-5f0052d19bef@suse.cz>
        <45a7e1bc-62cb-cf96-07c7-c4801dcf23d4@suse.cz>
        <20171002150048.3a609f57@kitsune.suse.cz>
        <eb224df4-615b-18e2-a9ee-5d98db9db225@suse.cz>
        <20171002155004.5878caee@kitsune.suse.cz>
        <6685d3eb-09b9-3904-1565-2bcfdc83eac5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2 Oct 2017 16:11:04 +0200
Stanislav Brabec <sbrabec@suse.cz> wrote:

> Michal Suchánek wrote:
> > On Mon, 2 Oct 2017 15:06:33 +0200
> > Stanislav Brabec <sbrabec@suse.cz> wrote:
> >   
> >> Michal Suchánek wrote:  
> >>> it is completely reasonable to return ENOMEDIUM from kernel when
> >>> the tray is open and let userspace decide if it wants to attempt
> >>> to close the tray and how long it wants to wait for the tray to
> >>> close (it may be blocked/broken).
> >>>     
> >> But then, what is the purpose of /proc/sys/dev/cdrom/autoclose?  
> > 
> > It can be used as a hint in mount if closing the tray is desired or
> > not.  
> 
> Such feature could be completely implemented in the user space, so
> there is no reason to stay in the kernel in such a limited form.
> 
> 20 years ago, it was a completely working implementation inside the
> kernel. User space just called mount(), and it succeeded.
> 
> If that requires user space loop loop, then there is no reason to
> implement sysfs entry just to perform tray close inside mount()
> syscall and then fail anyway.
> 
> > I guess this used to work with IDE drivers not using SCSI emulation.
> > 
> > With SCSI the close tray command is executed like any other with
> > default timeout and obviously does time out in most cases. 
> > 
> > But how long should the kernel wait? Is 1 minute ok? Should it wait
> > 5 minutes in case the user did not align the medium properly and
> > needs to realign it? Who should set this timeout, where?
> >   
> The timeout should be equal to the time to close tray on the slowest
> device. Guessing something about 3 to 5 seconds may be fine. After
> that time (or several times until that time), just check when the
> tray starts to report that it is closed.

It may take 5s to physically close the drive but it takes much longer
until the medium is detected and can be read. I suspect there might be
some issue with interpreting the timeout in SCSI ioctls, though.

You get 

/* The CDROM is fairly slow, so we need a little extra time */
/* In fact, it is very slow if it has to spin up first */
#define IOCTL_TIMEOUT 30*HZ

which looks like the intended timeout is 30s.

However, the timeout is passed like

cgc.timeout = IOCTL_TIMEOUT (units for struct packet_command
unspecified)

result = scsi_execute(SDev, cgc->cmd, cgc->data_direction,
                              cgc->buffer, cgc->buflen,
                              (unsigned char *)cgc->sense, &sshdr,
                              cgc->timeout, IOCTL_RETRIES, 0, 0, NULL);

and finally

**
 * scsi_execute - insert request and wait for the result
 * @sdev:       scsi device
 * @cmd:        scsi command
 * @data_direction: data direction
 * @buffer:     data buffer
 * @bufflen:    len of buffer
 * @sense:      optional sense buffer
 * @sshdr:      optional decoded sense header
 * @timeout:    request timeout in seconds
 * @retries:    number of times to retry request
 * @flags:      flags for ->cmd_flags
 * @rq_flags:   flags for ->rq_flags
 * @resid:      optional residual length
 *
 * Returns the scsi_cmnd result field if a command was executed, or a
negative
 * Linux error code if we didn't get that far.
 */
int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
                 int data_direction, void *buffer, unsigned bufflen,
                 unsigned char *sense, struct scsi_sense_hdr *sshdr,
                 int timeout, int retries, u64 flags, req_flags_t
rq_flags, int *resid)


meaning that the 30*HZ value is interpreted as seconds if the docs are
right. Looks fishy to me.

Thanks

Michal
