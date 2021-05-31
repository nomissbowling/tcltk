//-----------------------------------------------------------------------------
//
// (C) 2004     European Space Agency
//              European Space Operations Centre
//              Darmstadt, Germany
//
// -----------------------------------------------------------------------------
//
//  System          MCM4 - Monitoring and Control Module
//
// subsystem:	sicl
// 
// file:	vxi11core_clnt.c
//
// purpose:	RPC functions for VXI11 protocol to the GPIB/LAN gateway
//
// comments:	This file was originally automatically generated by rpcgen
//		It is now manually maintained with the MCM4 project
//
// authors:	H. Kubr
//
// history: 	Re-used from Siemens project
//
//-----------------------------------------------------------------------------
/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include <memory.h> /* for memset */
#include "vxi11core.h"

static char const rcsid[] =
                "VXI-SICL $Id: vxi11core_clnt.c,v 1.6 2010-01-13 12:09:04 maenner.o Exp $";

/* Default timeout can be changed using clnt_control() */
static struct timeval TIMEOUT = { 25, 0 };

int
device_abort_1(Device_Link *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_abort,
		(xdrproc_t) xdr_Device_Link, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
create_link_1(Create_LinkParms *argp, CLIENT *clnt, Create_LinkResp *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, create_link,
		(xdrproc_t) xdr_Create_LinkParms, (caddr_t) argp,
		(xdrproc_t) xdr_Create_LinkResp, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_write_1(Device_WriteParms *argp, CLIENT *clnt, Device_WriteResp *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_write,
		(xdrproc_t) xdr_Device_WriteParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_WriteResp, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_read_1(Device_ReadParms *argp, CLIENT *clnt, Device_ReadResp *clnt_res)
{
    /***
      ptype clnt_res
      type = struct Device_ReadResp {
	Device_ErrorCode error;
	long int reason;
	struct {
          u_int data_len;
          char *data_val;
	} data;
      } *
     ***/
        enum clnt_stat stat;
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	stat=clnt_call (clnt, device_read,
			(xdrproc_t) xdr_Device_ReadParms, (caddr_t) argp,
			(xdrproc_t) xdr_Device_ReadResp, (caddr_t) clnt_res,
			TIMEOUT);
	if (stat == RPC_TIMEDOUT) {
	    clnt_res->error=15; // I_ERR_TIMEOUT
	    stat=0;
	}
	if (stat != RPC_SUCCESS) {
	    return 0;
	}
	return 1;
}

int
device_readstb_1(Device_GenericParms *argp, CLIENT *clnt, Device_ReadStbResp *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_readstb,
		(xdrproc_t) xdr_Device_GenericParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_ReadStbResp, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_trigger_1(Device_GenericParms *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_trigger,
		(xdrproc_t) xdr_Device_GenericParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_clear_1(Device_GenericParms *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_clear,
		(xdrproc_t) xdr_Device_GenericParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_remote_1(Device_GenericParms *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_remote,
		(xdrproc_t) xdr_Device_GenericParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_local_1(Device_GenericParms *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_local,
		(xdrproc_t) xdr_Device_GenericParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_lock_1(Device_LockParms *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_lock,
		(xdrproc_t) xdr_Device_LockParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_unlock_1(Device_Link *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_unlock,
		(xdrproc_t) xdr_Device_Link, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_enable_srq_1(Device_EnableSrqParms *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_enable_srq,
		(xdrproc_t) xdr_Device_EnableSrqParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_docmd_1(Device_DocmdParms *argp, CLIENT *clnt, Device_DocmdResp *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, device_docmd,
		(xdrproc_t) xdr_Device_DocmdParms, (caddr_t) argp,
		(xdrproc_t) xdr_Device_DocmdResp, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
destroy_link_1(Device_Link *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, destroy_link,
		(xdrproc_t) xdr_Device_Link, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
create_intr_chan_1(Device_RemoteFunc *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, create_intr_chan,
		(xdrproc_t) xdr_Device_RemoteFunc, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
destroy_intr_chan_1(void *argp, CLIENT *clnt, Device_Error *clnt_res)
{
	memset((char *)clnt_res, 0, sizeof(*clnt_res));
	if (clnt_call (clnt, destroy_intr_chan,
		(xdrproc_t) xdr_void, (caddr_t) argp,
		(xdrproc_t) xdr_Device_Error, (caddr_t) clnt_res,
		TIMEOUT) != RPC_SUCCESS) {
		return 0;
	}
	return 1;
}

int
device_setlantimeout(struct timeval *timeout)  /** added for control of LAN timeout **/
{
        TIMEOUT.tv_sec = timeout->tv_sec;
        TIMEOUT.tv_usec = timeout->tv_usec;
        return 0;
}

int
device_getlantimeout(struct timeval *timeout)  /** added for control of LAN timeout **/
{
        timeout->tv_sec = TIMEOUT.tv_sec;
        timeout->tv_usec = TIMEOUT.tv_usec;
        return 0;
}
