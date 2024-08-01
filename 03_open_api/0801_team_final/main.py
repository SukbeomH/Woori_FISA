import streamlit as st
from streamlit_option_menu import option_menu
from views import bikeinfo, bikeloc


v_menu = ["대여소 정보 조회", "거리 계산"]

with st.sidebar:

    # st.header("MENU")

    selected = option_menu(
        menu_title="MENU",  # required
        options=v_menu,  # required
        icons=["bi bi-bicycle", "bi bi-signpost-split"],  # optional
        menu_icon="bi bi-menu-button",  # optional
        default_index=0,  # optional
        styles={
            "container": {"padding": "4!important", "background-color": "#fafafa"},
            "icon": {"color": "black", "font-size": "25px"},
            "nav-link": {
                "font-size": "16px",
                "text-align": "left",
                "margin": "0px",
                "--hover-color": "#fafafa",
            },
            "nav-link-selected": {"background-color": "#08c7b4"},
        },
    )

if selected == "거리 계산":
    bikeloc.createPage()

if selected == "대여소 정보 조회":
    bikeinfo.createPage()
